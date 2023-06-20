/ai/advanced/

	var/should_find_weapon = TRUE //Set to true if you want this AI to find a weapon if it has none.
	var/should_find_weapon_on_ground = FALSE //Set to true if you want the AI to find a weapon on the ground if it has none.
	var/checked_weapons = FALSE
	var/checked_grenades = FALSE
	var/checked_weapons_on_ground = FALSE
	var/suicide_bomber = FALSE //Set to true if it is supposed to prime the grenade but not throw it.

	var/obj/item/grenade/found_grenade = null

	var/obj/item/weapon/objective_weapon
	var/attack_delay_left
	var/attack_delay_right

	var/next_complex = 0

	var/resist_handcuffs = TRUE

	use_astar_on_frustration_move = TRUE

	//Gun handling
	var/obj/item/bullet_cartridge/last_found_bullet
	var/desired_shell_reload = 0

	var/grenade_chance = 1 //Percent change to use a grenade each combat tick.

	var/should_find_ammo_pile_on_empty = FALSE //Set to true if this AI should find an ammo pile if the NPC has no ammo.
	var/obj/structure/interactive/storage/ammo_pile/found_ammo_pile

	var/avoid_threats = TRUE

	use_alert_overlays = TRUE

	attack_movement_obstructions = FALSE

	var/use_cover_chance = 100
	var/obj/marker/cover_node/current_cover
	var/checked_cover = TRUE //Set to false when the mob equips a new weapon.

	//For smart targeting
	var/turf/old_owner_location
	var/turf/old_objective_attack_location

/ai/advanced/PreDestroy()
	remove_cover()
	. = ..()

/ai/advanced/Destroy()
	objective_weapon = null
	return ..()

/ai/advanced/on_life()

	var/mob/living/advanced/A = owner
	if(resist_handcuffs && A.handcuffed && owner.next_resist <= world.time)
		owner.resist()

	if(found_ammo_pile)
		var/obj/item/weapon/ranged/bullet/right_hand_weapon = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
		var/obj/item/weapon/ranged/bullet/left_hand_weapon = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()
		if(!is_ranged_bullet_weapon(left_hand_weapon))
			left_hand_weapon = null
		if(!is_ranged_bullet_weapon(right_hand_weapon))
			right_hand_weapon = null
		if(!left_hand_weapon && !right_hand_weapon)
			found_ammo_pile = null //Didn't have a valid weapon.
		else
			if(!length(astar_path_current)) //Couldn't path properly. Try again.
				found_ammo_pile = null
				find_ammo_pile()
			if(found_ammo_pile && get_dist(owner,found_ammo_pile) <= 1)
				//Restock
				if(right_hand_weapon)
					create_ammo_for_weapon(right_hand_weapon)
				if(left_hand_weapon)
					create_ammo_for_weapon(left_hand_weapon)
				found_ammo_pile = null

	return ..()

/ai/advanced/proc/create_ammo_for_weapon(var/obj/item/weapon/ranged/bullet/W,var/desired_amount=5,var/drop_on_fail=TRUE)

	. = FALSE

	var/mob/living/advanced/A = owner

	if(SSbalance.weapon_to_magazine[W.type]) //Magazines.
		for(var/i=1,i<=desired_amount,i++)
			var/obj/item/magazine/M = SSbalance.weapon_to_magazine[W.type]
			M = new M (found_ammo_pile.loc)
			INITIALIZE(M)
			GENERATE(M)
			FINALIZE(M)
			if(!M.quick_equip(A,ignore_hands=TRUE))
				qdel(M)
				break
			. = TRUE
		return .

	if(SSbalance.weapon_to_bullet[W.type]) //Bullets.
		for(var/i=1,i<=desired_amount,i++)
			var/obj/item/bullet_cartridge/B = SSbalance.weapon_to_bullet[W.type]
			B = new B (found_ammo_pile.loc)
			B.amount = B.amount_max
			INITIALIZE(B)
			GENERATE(B)
			FINALIZE(B)
			if(!B.quick_equip(A,ignore_hands=TRUE))
				qdel(B)
				break
			. = TRUE

	if(!. && drop_on_fail)
		W.drop_item(get_turf(owner))





/ai/advanced/proc/handle_movement_weapon()

	if(!objective_weapon)
		return FALSE

	if(!is_turf(objective_weapon.loc))
		objective_weapon = null
		return FALSE

	if(get_dist(owner,objective_weapon) > 1)
		owner.move_dir = get_dir(owner,objective_weapon)
		return TRUE

	equip_weapon(objective_weapon)
	objective_weapon = null

	return FALSE


/ai/advanced/proc/handle_movement_avoidance()

	if(!objective_attack) //Combat only.
		return FALSE

	if(!owner.loc || !is_turf(owner.loc))
		return FALSE

	var/list/avoidance_list = SSai.tracked_avoidance_by_z["[owner.loc.z]"]

	var/avoidance_list_length = length(avoidance_list)

	if(!avoidance_list_length)
		return FALSE

	if(debug) log_debug("Avoidance list length: [avoidance_list_length].")

	var/directions_to_avoid = 0x0
	for(var/k in avoidance_list)
		var/atom/movable/M = k
		if(!M)
			avoidance_list -= k
			continue
		if(M.qdeleting)
			log_error("Warning: Qdeleting object [M.get_debug_name()] was found in tracked ai avoidances.")
			avoidance_list -= k
			continue
		if(owner.z != M.z)
			log_error("Warning: Object [M.get_debug_name()] was found in a mismatched z-list in tracked ai avoidances (Reported: [owner.z], Actual: [M.z]).")
			avoidance_list -= k
			continue
		if(get_dist(M,owner) >= VIEW_RANGE*0.75)
			continue
		directions_to_avoid |= get_dir(owner,M)

	if(!directions_to_avoid)
		return FALSE

	var/good_direction = (NORTH | EAST | SOUTH | WEST) & ~directions_to_avoid

	if((good_direction & NORTH) && (good_direction && SOUTH))
		good_direction &= ~(NORTH|SOUTH)

	if((good_direction & EAST) && (good_direction && WEST))
		good_direction &= ~(EAST|WEST)

	if(debug)
		log_debug("Running away to the [dir2text(good_direction)] due to avoidance.")

	owner.move_dir = good_direction
	owner.movement_flags = MOVEMENT_RUNNING

	return TRUE

/ai/advanced/proc/find_nearby_weapon()

	var/list/possible_weapons = list()

	for(var/obj/item/weapon/W in view(VIEW_RANGE*0.4,owner))
		if(!W.z)
			continue
		var/weight_multiplier = 1
		if(is_ranged_bullet_weapon(W))
			var/obj/item/weapon/ranged/bullet/B = W
			if(!B.chambered_bullet)
				continue
			weight_multiplier = 3
		if(is_ranged_weapon(W))
			var/obj/item/weapon/ranged/R = W
			if(!R.can_gun_shoot(owner,check_time=FALSE,messages=FALSE))
				continue
			weight_multiplier = 3
		possible_weapons[W] = (max(1,(VIEW_RANGE + 1) - get_dist(owner,W.loc)))*weight_multiplier

	if(!length(possible_weapons))
		return null

	return pickweight(possible_weapons)

/ai/advanced/proc/handle_equipment() //Return true to avoid regular attack.

	var/mob/living/advanced/A = owner

	if(!found_grenade && !checked_grenades && objective_attack && prob(grenade_chance) && get_dist(owner,objective_attack) >= 6)
		if(!find_grenade()) //Find a grenade to throw.
			checked_grenades = TRUE //Stop checking grenades as we can't find anymore.
		return TRUE

	if(found_grenade)
		if(!handle_grenade(found_grenade))
			found_grenade = null
		return TRUE

	if(found_ammo_pile) //Likely fleeing to an ammo pile. Probably. Hopefully.
		return TRUE

	var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
	var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()

	if(should_find_weapon_on_ground && !checked_weapons_on_ground && !left_item && !right_item && !objective_weapon)
		objective_weapon = find_nearby_weapon()
		if(!objective_weapon) checked_weapons_on_ground = TRUE

	if(left_item)
		checked_weapons_on_ground = FALSE
		if(is_ranged_bullet_weapon(left_item) && handle_gun(left_item))
			return TRUE
		if(is_bow(left_item) && handle_bow(left_item))
			return TRUE
		if(left_item && A.inventories_by_id[BODY_HAND_RIGHT_HELD] && left_item.can_wield && !left_item.wielded && !right_item)
			A.inventories_by_id[BODY_HAND_RIGHT_HELD].wield(A,left_item)
			next_complex = max(next_complex,world.time) + rand(2,6)

	if(right_item)
		checked_weapons_on_ground = FALSE
		if(is_ranged_bullet_weapon(right_item) && handle_gun(right_item))
			return TRUE
		if(is_bow(right_item) && handle_bow(right_item))
			return TRUE
		if(right_item && A.inventories_by_id[BODY_HAND_LEFT_HELD] && right_item.can_wield && !right_item.wielded && !left_item)
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,right_item)
			next_complex = max(next_complex,world.time) + rand(2,6)

	return FALSE

/ai/advanced/proc/handle_grenade(var/obj/item/grenade/G)

	if(!G || !is_inventory(G.loc))
		return FALSE

	var/mob/living/advanced/A = owner
	if(!G.stored_trigger) //Bad grenade, doesn't even work. Drop it.
		if(debug) log_debug("Dropping a bad grenade as it doesn't have a stored trigger...")
		G.drop_item(get_turf(A))
		return FALSE

	if(G.stored_trigger.active && !suicide_bomber) //Live nade, throw it!
		var/atom/real_target = objective_attack
		if(real_target)
			var/atom/blocking_atom = get_line_bullet(owner,objective_attack,collision_flag=FLAG_COLLISION_BULLET_SOLID,return_list=FALSE)
			if(blocking_atom && get_dist(owner,blocking_atom) <= 4)
				real_target = null
				if(debug) log_debug("Detected an unsafe grenade throw...")
		if(!real_target)
			if(debug) log_debug("Finding a place to dispose of the grenade...")
			var/list/valid_turfs = list()
			for(var/turf/simulated/floor/F in view(VIEW_RANGE,A))
				if(get_dist(F,A) <= VIEW_RANGE*0.5)
					continue
				valid_turfs += F
			if(length(valid_turfs))
				real_target = pick(valid_turfs)

		if(real_target)
			var/list/offsets = get_directional_offsets(owner,real_target)
			if(debug) log_debug("Throwing the grenade!")
			G.drop_item(get_turf(owner))
			if(offsets[1] || offsets[2])
				var/throw_velocity = 10
				G.throw_self(owner,real_target,16,16,offsets[1]*throw_velocity,offsets[2]*throw_velocity,lifetime = SECONDS_TO_DECISECONDS(4), steps_allowed = VIEW_RANGE, desired_loyalty_tag = owner.loyalty_tag)
		else
			if(debug) log_debug("Dropping the grenade because of weird fuckery.")
			G.drop_item(get_turf(A)) //Bad grenade. This will rarely happen due to the above turf checking but this is for weird cases.

		//The whole real_target checking multiple times seems ugly but what can you do.
		next_complex = world.time + rand(5,10)
		return FALSE

	if(objective_attack)
		var/atom/blocking_atom = get_line_bullet(owner,objective_attack,collision_flag=FLAG_COLLISION_BULLET_SOLID,return_list=FALSE)
		if(blocking_atom && get_dist(owner,blocking_atom) <= 4) //Unsafe throw
			next_complex = world.time + 10
			return FALSE
		var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
		var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()
		if(left_item != G && right_item != G) //The nade needs to be in our hands.
			if(debug) log_debug("The grenade is not in our hands...")

			if(left_item && left_item.wielded)
				A.inventories_by_id[BODY_HAND_RIGHT_HELD].unwield(A,left_item)

			if(right_item && right_item.wielded)
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,right_item)

			if(!left_item || !right_item || (left_item && src.unequip_weapon(left_item)) || (right_item && src.unequip_weapon(right_item)))
				if(debug) log_debug("Trying to put the grenade in our hands...")
				if(!A.put_in_hands(G))
					return FALSE //Can't even throw a grenade in the first place.
			next_complex = world.time + rand(5,10)
			return TRUE
		else //Time to arm the grenade.
			if(debug) log_debug("Arming the grenade!")
			G.click_self(A)
			next_complex = world.time + rand(5,30)
			return TRUE

	return FALSE //Well, shit's fucked.

/ai/advanced/proc/handle_bow(var/obj/item/weapon/ranged/bow/R)

	if(R.next_shoot_time > world.time)
		return TRUE

	var/mob/living/advanced/A = owner

	var/obj/hud/inventory/I_hand = A.inventories_by_id[BODY_HAND_LEFT_HELD]
	var/obj/hud/inventory/I_groin = A.inventories_by_id[BODY_GROIN_O]
	if(!I_hand || !I_groin) //If you don't have a hand, what's the point of using a bow?
		R.drop_item(get_turf(A))
		next_complex = max(next_complex,world.time) + 10
		return TRUE

	var/obj/item/bullet_cartridge/arrow/B = I_hand.get_top_object()
	if(!B || !istype(B)) //We're not holding an arrow.
		var/obj/item/clothing/belt/belt_quiver/BQ = I_groin.get_top_object()
		if(!BQ || !istype(BQ) || !length(BQ.stored_arrows)) //No quiver with arrows found, what's the point of using a bow?
			R.drop_item(get_turf(A))
			next_complex = max(next_complex,world.time) + 10
			return TRUE
		BQ.take_arrow(A,I_hand)
		next_complex = max(next_complex,world.time) + rand(3,6)
		return TRUE

	if(R.stage_current > 0) //Currently drawing the bow to fire it.
		if(R.stage_current >= R.stage_max && prob(80))
			R.on_mouse_up(A,objective_attack) //This fires the bow.
			next_complex = max(next_complex,world.time) + rand(5,10)
		return TRUE

	return FALSE //All good.

/ai/advanced/proc/handle_gun(var/obj/item/weapon/ranged/R) //Handles all the reloading and other stuff.

	//Returning TRUE means don't attack on the same tick. It's good to return true if you want the shooter to wait before firing.

	if(R.next_shoot_time > world.time)
		return TRUE

	var/mob/living/advanced/A = owner
	//var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
	var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()

	if(istype(R,/obj/item/weapon/ranged/bullet/magazine/))
		var/obj/item/weapon/ranged/bullet/magazine/G = R
		if(!G.stored_magazine && !G.chambered_bullet) //Find one
			if(G.wielded) //We should unwield
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,15)
				if(debug) log_debug("Unwelding to make room in hands for a magazine...")
				return TRUE
			var/obj/item/magazine/M
			var/obj/item/organ/O_groin = A.labeled_organs[BODY_GROIN]
			if(O_groin)
				M = recursive_find_item(O_groin,G,/obj/item/weapon/ranged/bullet/magazine/proc/can_fit_magazine)
				if(debug) log_debug("Finding a new magazine: [M ? "SUCCESS" : "FAIL"].")
			if(!M)
				if(!should_find_ammo_pile_on_empty || !find_ammo_pile())
					G.drop_item(get_turf(owner)) //IT'S NO USE. No magazines left.
					if(debug) log_debug("Couldn't find an ammo pile to loot. Dropping weapon...")
				else
					if(debug) log_debug("Found an ammo pile to loot...")
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,10)
				return TRUE
			if(debug) log_debug("Putting the magazine in...")
			M.click_on_object(A,G)
			if(!G.stored_magazine)
				G.drop_item(get_turf(owner)) //IT'S NO USE. Something went wrong with reloading the magazine.
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,10)
				if(debug) log_debug("Failed to put the magazine in! Something weird went wrong!")
				return TRUE
			if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !left_item)
				if(debug) log_debug("Wielding the weapon again to fire it...")
				A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(2,6)
				return TRUE
			return TRUE

		if(G.stored_magazine && !G.stored_magazine.get_ammo_count() && !G.chambered_bullet)
			if(debug) log_debug("Ejecting the magazine as it contains no bullets...")
			G.eject_magazine(A)
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(10,20)
			return TRUE

		if(!G.chambered_bullet || G.chambered_bullet.is_spent)
			if(debug) log_debug("Cocking the gun as it has no bullet in the chamber...")
			G.click_self(A)
			if(!G.chambered_bullet)
				G.drop_item(get_turf(owner)) //IT'S NO USE. Something went wrong with chambering the bullet.
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,10)
				if(debug) log_debug("Failed to cock the gun! Something weird went wrong!")
				return TRUE
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,10)
			return TRUE

		return FALSE //All good.

	if(istype(R,/obj/item/weapon/ranged/bullet/revolver))
		var/obj/item/weapon/ranged/bullet/revolver/G = R
		if(!G.stored_bullets[G.current_chamber] || G.stored_bullets[G.current_chamber].is_spent || desired_shell_reload > 0)
			if(debug) log_debug("Discovered that there is no valid bullet in the current cylinder...")
			if(desired_shell_reload > 0)
				var/has_valid_bullet = FALSE
				for(var/k in G.stored_bullets)
					var/obj/item/bullet_cartridge/B = G.stored_bullets[k]
					if(!B || B.is_spent)
						continue
					has_valid_bullet = k
					break
				if(has_valid_bullet)
					if(debug) log_debug("Rotating the cylinder as there is still an unspent bullet...")
					G.rotate_cylinder(clamp(has_valid_bullet - G.current_chamber,-1,1)) //There is another valid bullet somewhere.
					next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(3,5)
					return TRUE

			if(G.wielded) //We should unwield
				if(debug) log_debug("Unwielding the gun to make room in hands for bullets...")
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,15)
				return TRUE

			if(!G.open)
				if(debug) log_debug("Opening the cylinder to insert bullets...")
				G.click_self(A) //Open it.
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,15)
				return TRUE

			if(G.stored_bullets[G.current_chamber] && G.stored_bullets[G.current_chamber].is_spent) //despite opening the chamber, there are still bullets, remove them.
				if(debug) log_debug("Removing spent bullet.")
				G.eject_stored_bullet(A,G.stored_bullets[G.current_chamber],get_turf(src))
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(2,5)
				return TRUE

			var/obj/item/bullet_cartridge/B
			if(last_found_bullet && !last_found_bullet.qdeleting && !last_found_bullet.is_spent) //Is last_found_bullet even valid?
				var/obj/hud/inventory/I = last_found_bullet.loc
				if(istype(I) && I.owner == owner)
					B = last_found_bullet
				else
					last_found_bullet = null
			else
				last_found_bullet = null
			var/obj/item/magazine/clip/C
			if(!B) //Why look for a clip if we inserted a bullet previously and found it?
				var/obj/item/organ/O_groin = A.labeled_organs[BODY_GROIN]
				if(O_groin)
					C = recursive_find_item(O_groin,G,/obj/item/weapon/ranged/bullet/revolver/proc/can_fit_clip)
					if(!C)
						B = recursive_find_item(O_groin,G,/obj/item/weapon/ranged/bullet/proc/can_fit_bullet) //It is implied we couldn't find B earlier.
			if(C)
				if(debug) log_debug("Found a valid clip to insert. Inserting...")
				C.click_on_object(A,G)
				C.drop_item(get_turf(owner)) //We have no use for the clip; drop it.
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,10)
				return TRUE
			if(B)
				if(debug) log_debug("Found a valid bullet to insert. Inserting...")
				B.click_on_object(A,G)
				var/missing_bullets = 0
				for(var/k in G.stored_bullets)
					if(k)
						continue
					missing_bullets++
				desired_shell_reload = missing_bullets
				if(desired_shell_reload > 0)
					last_found_bullet = B
				else
					last_found_bullet = null
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(2,5)
				return TRUE

			desired_shell_reload = 0
			if(!should_find_ammo_pile_on_empty || !find_ammo_pile())
				if(debug) log_debug("Couldn't find a valid ammo pile to loot. Dropping weapon...")
				G.drop_item(get_turf(owner)) //Can't find anything, so drop it.
			else
				if(debug) log_debug("Found a valid ammo pile to loot...")
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,10)
			return TRUE

		if(G.open && !G.can_shoot_while_open) //https://www.youtube.com/watch?v=ZiEGi2g1JkA
			if(debug) log_debug("Closing the cylinder so we can fire it...")
			G.click_self(A)
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,15)
			return TRUE

		desired_shell_reload = 0 //All good.
		if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !left_item)
			if(debug) log_debug("Wielding the gun so we can fire it...")
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(2,6)
			return TRUE

		return FALSE //All good.

	if(istype(R,/obj/item/weapon/ranged/bullet/pump))
		var/obj/item/weapon/ranged/bullet/pump/G = R

		if((!G.chambered_bullet && G.stored_bullets[1]) || (G.chambered_bullet && G.chambered_bullet.is_spent))
			if(debug) log_debug("Pumping the gun to load in a new round...")
			G.click_self(owner) //Chamber a new round in.
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(1,3)
			return TRUE

		var/max_length = length(G.stored_bullets)
		if(!G.stored_bullets[1] || max_length < desired_shell_reload)
			desired_shell_reload = clamp(
				round(
					rand(
						max_length*(owner.health.health_current/owner.health.health_max),
						max_length
					),
					1
				),
				1,
				max_length
			) //Get a new value of how much we should load in.

		if(desired_shell_reload > 0 && !G.stored_bullets[desired_shell_reload])
			if(G.wielded) //We should unwield
				if(debug) log_debug("Unwielding the gun to make room for holding bullets...")
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,15)
				return TRUE
			var/obj/item/bullet_cartridge/B
			if(last_found_bullet && !last_found_bullet.qdeleting && !last_found_bullet.is_spent && G.can_fit_bullet(last_found_bullet))
				var/obj/hud/inventory/I = last_found_bullet.loc
				if(istype(I) && I.owner == owner)
					B = last_found_bullet
			else
				last_found_bullet = null
			var/obj/item/organ/O_groin = A.labeled_organs[BODY_GROIN]
			if(O_groin && !B)
				B = recursive_find_item(O_groin,G,/obj/item/weapon/ranged/bullet/proc/can_fit_bullet)
			if(!B)
				if(!should_find_ammo_pile_on_empty || !find_ammo_pile())
					if(debug) log_debug("Couldn't find a valid ammo pile. Dropping weapon...")
					G.drop_item(get_turf(owner)) //IT'S NO USE. Can't find any shells to put in.
				else
					if(debug) log_debug("Found a valid ammo pile to loot...")
				next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,10)
				return FALSE
			if(debug) log_debug("Inserting a bullet into the gun...")
			B.click_on_object(A,G)
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,8)
			return TRUE

		desired_shell_reload = 0 //All good.
		if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !left_item)
			if(debug) log_debug("Wielding the gun so we can shoot...")
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
			next_complex = max(next_complex,world.time,G.next_shoot_time) + rand(5,8)
			return TRUE

		return FALSE //All good.

	return FALSE //Weird but okay

/ai/advanced/handle_movement()

	if(avoid_threats && handle_movement_avoidance())
		last_movement_proc = "avoidance"
		return TRUE

	if(current_cover && objective_attack && handle_movement_cover())
		last_movement_proc = "cover"
		return TRUE

	if(handle_movement_weapon())
		last_movement_proc = "weapon"
		return TRUE

	. = ..()

/ai/advanced/do_attack(var/atom/target,var/left_click=FALSE)



	if(!target)
		return FALSE

	var/mob/living/advanced/A = owner

	if(!A)
		return FALSE

	var/list/params = list(
		PARAM_ICON_X = 16,
		PARAM_ICON_Y = 16,
		"left" = 0,
		"right" = 0,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	if(debug) log_debug("Do attack: [target].")

	if(left_click)
		params["left"] = TRUE
		owner.on_left_down(target,null,null,params)
	else
		params["right"] = TRUE
		owner.on_right_down(target,null,null,params)

	return TRUE

/ai/advanced/proc/is_grenade(var/atom/A)
	return istype(A,/obj/item/grenade/)

/ai/advanced/proc/find_grenade()

	var/mob/living/advanced/A = owner
	var/obj/item/organ/O_groin = A.labeled_organs[BODY_GROIN]
	if(!O_groin)
		return FALSE

	var/obj/item/grenade/G = recursive_find_item(O_groin,src,src::is_grenade())
	if(G)
		if(debug) log_debug("AI debug: Found a grenade!")
		found_grenade = G
	else
		if(debug) log_debug("AI debug: Did not find a grenade!")

	return TRUE

/ai/advanced/proc/find_best_weapon(var/atom/possible_target)

	var/mob/living/advanced/A = owner

	var/obj/item/weapon/best_weapon
	var/best_weapon_value = 0

	var/distance_check = possible_target ? get_dist(owner,possible_target) : VIEW_RANGE

	var/list/lists_to_check = A.worn_objects + A.held_objects

	for(var/obj/item/weapon/W in lists_to_check)
		var/weapon_value = (istype(W,/obj/item/weapon/ranged) && distance_check >= 3 ? 1 : 0.2)
		weapon_value *= W.value
		if(!best_weapon || weapon_value > best_weapon_value)
			best_weapon = W
			best_weapon_value = weapon_value
			continue

	return best_weapon

/ai/advanced/proc/equip_weapon(var/obj/item/weapon/W)

	var/mob/living/advanced/A = owner

	if(A.dead)
		return FALSE

	. = FALSE

	var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
	var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()

	if(A.inventories_by_id[BODY_HAND_RIGHT_HELD] && !right_item)
		. = A.inventories_by_id[BODY_HAND_RIGHT_HELD].add_object(W)
		if(. && A.inventories_by_id[BODY_HAND_LEFT_HELD] && W.can_wield && !W.wielded && !left_item)
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,W)
	else if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && !A.inventories_by_id[BODY_HAND_LEFT_HELD].parent_inventory && !left_item)
		. = A.inventories_by_id[BODY_HAND_LEFT_HELD].add_object(W)
	if(. && istype(W,/obj/item/weapon/melee/energy))
		var/obj/item/weapon/melee/energy/E = W
		if(!E.enabled) E.click_self(A)

	checked_weapons = FALSE
	checked_cover = FALSE

/ai/advanced/proc/unequip_weapon(var/obj/item/weapon/W)
	var/mob/living/advanced/A = owner
	if(A.dead)
		return FALSE
	if(W.additional_clothing_parent)
		return FALSE
	if(istype(W,/obj/item/weapon/melee/energy))
		var/obj/item/weapon/melee/energy/E = W
		if(E.enabled) E.click_self(A)
	if(!W.quick_equip(A,ignore_hands=TRUE))
		W.drop_item(get_turf(owner))
	checked_weapons = FALSE
	checked_cover = FALSE
	return TRUE



/ai/advanced/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	var/mob/living/advanced/A = owner

	var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
	var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()

	if(new_alert_level == ALERT_LEVEL_COMBAT || new_alert_level == ALERT_LEVEL_CAUTION)
		if(!left_item && !right_item)
			var/obj/item/weapon/W = find_best_weapon(alert_source)
			if(W) equip_weapon(W)
	else if(new_alert_level == ALERT_LEVEL_NONE)
		if(right_item) unequip_weapon(right_item)
		if(left_item) unequip_weapon(left_item)

	return ..()

/ai/advanced/handle_attacking()

	var/mob/living/advanced/A = owner

	distance_target_min = 1
	distance_target_max = 1
	attack_distance_min = 1
	attack_distance_max = 1

	var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
	var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()

	if(right_item && !left_item)
		left_click_chance = 100
		attack_distance_min = right_item.combat_range*0.5
		attack_distance_max = right_item.combat_range
	else if(!right_item && left_item)
		left_click_chance = 0
		attack_distance_min = left_item.combat_range*0.5
		attack_distance_max = left_item.combat_range
	else if(left_item && right_item)
		attack_distance_min = min(right_item.combat_range,left_item.combat_range)*0.5
		attack_distance_max = max(right_item.combat_range,left_item.combat_range)
		var/attack_distance_check = get_dist(owner,objective_attack)
		if(attack_distance_check <= right_item.combat_range && attack_distance_check <= left_item.combat_range)
			left_click_chance = 50
		else if(attack_distance_check <= right_item.combat_range)
			left_click_chance = 100
		else if(attack_distance_check <= left_item.combat_range)
			left_click_chance = 0

	distance_target_max = min(VIEW_RANGE,attack_distance_max)

	if(objective_attack && !checked_cover && attack_distance_max > 3)
		checked_cover = TRUE
		if(use_cover_chance > 0 && prob(use_cover_chance))
			find_and_set_cover(objective_attack)

	if(!checked_weapons && objective_attack && abs(get_dist(owner,objective_attack) - attack_distance_max) > VIEW_RANGE*0.5) //Find a new weapon to use if our enemy is close/far.
		var/obj/item/weapon/W = find_best_weapon(objective_attack)
		if(W)
			if(right_item != W && left_item != W)
				if(right_item) unequip_weapon(right_item)
				if(left_item) unequip_weapon(left_item)
				equip_weapon(W)
		else
			checked_weapons = TRUE // No point in checking for something that doesn't exist.

	if(next_complex > world.time)
		return FALSE

	//Smart targeting. Prevents AI from shooting walls.
	//This better not be intensive
	if(distance_target_max >= 2 && objective_attack && owner.z && objective_attack.z && owner.z == objective_attack.z && get_dist(owner,objective_attack) >= 2)

		var/turf/current_owner_location = get_turf(owner)
		var/turf/current_objective_attack_location = get_turf(objective_attack)

		if(old_owner_location != current_owner_location || current_objective_attack_location != old_objective_attack_location)
			old_owner_location = old_owner_location
			old_objective_attack_location = current_objective_attack_location
			if(debug) log_debug("Checking bullet blockers...")
			var/obj/item/weapon/ranged/R
			if(is_ranged_weapon(right_item))
				R = right_item
			else if(is_ranged_weapon(left_item))
				R = left_item
			if(R && R.next_shoot_time <= world.time)
				if(debug) log_debug("Checking bullet blockers: Found weapon.")
				var/obj/projectile/P
				if(R.projectile)
					P = R.projectile
				else if(istypecache(R,/obj/item/weapon/ranged/bullet))
					var/obj/item/weapon/ranged/bullet/RB = R
					if(RB.chambered_bullet)
						P = RB.chambered_bullet.projectile
				if(P)
					var/found_collision_flag = initial(P.collision_bullet_flags)
					if(debug) log_debug("Checking bullet blockers: Found projectile: [P]. Flag: [found_collision_flag]")
					if(found_collision_flag)
						if(debug) log_debug("Checking bullet blockers: Found collision flag.")
						var/atom/found_atom = get_line_bullet(owner,objective_attack,collision_flag=found_collision_flag,return_list=FALSE)
						if(found_atom && found_atom.map_spawn && (get_dist(found_atom,objective_attack) >= 3 || get_dist(found_atom,owner) <= 2) ) //Don't bother shooting at nothing (or your own cover).
							if(debug) log_debug("Checking bullet blockers: Found atom.")
							if(debug)
								found_atom.color = "#FF0000"
							return FALSE

	if(handle_equipment())
		return FALSE

	. = ..()

/ai/advanced/proc/find_ammo_pile()

	for(var/obj/structure/interactive/storage/ammo_pile/AP in range(VIEW_RANGE,owner))
		if(!AP.stored_loot)
			continue
		if(set_path_astar(get_turf(AP),1))
			found_ammo_pile = AP
			return TRUE

	return FALSE


/ai/advanced/proc/remove_cover()

	if(current_cover)
		current_cover.reserved = FALSE
		current_cover = null
		return TRUE

	return FALSE


/ai/advanced/proc/find_and_set_cover(var/atom/enemy)

	var/turf/T = get_turf(owner)

	var/obj/marker/cover_node/best_cover
	var/best_cover_distance

	var/obj/marker/cover_node/CN
	FOR_DVIEW(CN,VIEW_RANGE,T,101)
		if(!(CN.dir & get_dir(CN,enemy)))
			continue
		if(CN.reserved)
			continue
		var/distance_to_cover = get_dist(T,CN)
		var/distance_to_enemy = get_dist(CN,enemy)
		if(attack_distance_max < distance_to_enemy || attack_distance_min > distance_to_enemy) //Too far || too close.
			distance_to_cover *= 2 //Still viable, just a worse weight.
		if(best_cover && distance_to_cover >= best_cover_distance)
			continue
		best_cover = CN
		best_cover_distance = distance_to_cover

	END_FOR_DVIEW

	if(!best_cover)
		if(debug) log_debug("Couldn't find any valid covers.")
		return FALSE
	if(current_cover) remove_cover()

	current_cover = best_cover
	current_cover.reserved = TRUE

	if(debug) log_debug("Found a good cover.")

	return TRUE




/ai/advanced/proc/handle_movement_cover()

	if(length(astar_path_current))
		return FALSE

	var/turf/T_cover = get_turf(current_cover)
	var/turf/T_owner = get_turf(owner)

	if(get_dist(T_cover,T_owner) > 1) //More than 1 tile away from cover.
		if(!set_path_astar(T_cover)) //Set a path to the cover if we're too far away.
			remove_cover() //If it fails, disregard the cover.
		return FALSE

	// var/mob/living/advanced/A = owner

	var/should_be_in_cover = FALSE
	if(!(found_grenade?.stored_trigger?.active)) //A little confusing but it just prevents the below from running if there is a grenade and we should obviously never be in cover with an active grenade.
		if(next_complex > world.time)
			should_be_in_cover = TRUE
		/*
		else if(left_item && istype(left_item,/obj/item/weapon/ranged/bullet/))
			var/obj/item/weapon/ranged/bullet/B = left_item
			if(!B.chambered_bullet)
				should_be_in_cover = TRUE
		else if(right_item && istype(right_item,/obj/item/weapon/ranged/bullet/))
			var/obj/item/weapon/ranged/bullet/B = right_item
			if(!B.chambered_bullet)
				should_be_in_cover = TRUE
		*/

	//We should be in cover.
	if(should_be_in_cover)
		if(T_owner != T_cover)
			owner.move_dir = get_dir(T_owner,T_cover)
			if(debug) log_debug("Moving to cover [dir2text(owner.move_dir)].")
			owner.movement_flags = MOVEMENT_WALKING
		else
			owner.move_dir = 0x0
			if(debug) log_debug("In cover.")
		return TRUE

	//We should be out of cover.
	var/turf/turf_to_step
	if(current_cover.turn_dir == 0x0) //Dual cover. Consider both sides.
		var/T_objective = get_turf(objective_attack)
		var/turf/T1 = get_step(T_cover,turn(current_cover.dir,90))
		var/turf/T2 = get_step(T_cover,turn(current_cover.dir,-90))
		var/T1_dist = get_dist(T1,T_objective)
		var/T2_dist = get_dist(T2,T_objective)
		if(T1_dist == T2_dist) //Doesn't matter. Pick one.
			turf_to_step = pick(T1,T2)
		else if(T1_dist < T2_dist) //Which one is closer to our target?
			turf_to_step = T1
		else
			turf_to_step = T2
	else
		turf_to_step = get_step(T_cover,turn(current_cover.dir,current_cover.turn_dir))

	//Are we in the right cover?
	if(T_owner != turf_to_step)
		owner.move_dir = get_dir(T_owner,turf_to_step)
		owner.movement_flags = MOVEMENT_WALKING
		if(debug) log_debug("Moving out of cover [dir2text(owner.move_dir)].")
		return TRUE

	owner.move_dir = 0x0 //We are where we should be.

	return TRUE

/ai/advanced/set_objective(var/atom/A)

	. = ..()

	if(. && current_cover && !objective_attack)
		remove_cover()