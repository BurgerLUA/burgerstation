/ai/advanced/

	var/should_find_weapon = TRUE //Set to true if you want this AI to find a weapon if it has none.
	var/should_find_weapon_on_ground = FALSE //Set to true if you want the AI to find a weapon on the ground if it has none.
	var/checked_weapons = FALSE
	var/checked_grenades = FALSE
	var/checked_weapons_on_ground = FALSE

	var/found_grenade = null

	var/obj/item/weapon/objective_weapon
	var/attack_delay_left
	var/attack_delay_right

	var/next_complex = 0

	var/resist_handcuffs = TRUE

	use_pathfinding = TRUE

	roaming_distance = 0

	//Gun handling
	var/obj/item/bullet_cartridge/last_found_bullet
	var/desired_shell_reload = 0

	var/grenade_chance = 5 //Percent change to use a grenade each combat tick.

	var/should_find_ammo_pile_on_empty = FALSE //Set to true if this AI should find an ammo pile if the NPC has no ammo.
	var/obj/structure/interactive/storage/ammo_pile/found_ammo_pile

	var/avoid_threats = TRUE

	attack_movement_obstructions = FALSE

/ai/advanced/Destroy()
	objective_weapon = null
	return ..()

/ai/advanced/on_life()

	var/mob/living/advanced/A = owner
	if(resist_handcuffs && A.handcuffed && owner.next_resist <= world.time)
		owner.resist()

	if(found_ammo_pile)
		var/obj/item/weapon/ranged/bullet/left_hand_weapon = A.left_item
		var/obj/item/weapon/ranged/bullet/right_hand_weapon = A.right_item
		if(!istype(left_hand_weapon))
			left_hand_weapon = null
		if(!istype(right_hand_weapon))
			right_hand_weapon = null
		if(!left_hand_weapon && !right_hand_weapon)
			found_ammo_pile = null //Didn't have a valid weapon.
		else
			if(!length(current_path_astar)) //Couldn't path properly. Try again.
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

	if(!isturf(objective_weapon.loc))
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

	if(!owner.z)
		return FALSE

	var/directions_to_avoid = 0x0
	var/list/avoidance_list = SSai.tracked_avoidance_by_z["[owner.z]"]

	if(debug) log_debug("Avoidance list length: [length(avoidance_list)].")

	for(var/k in avoidance_list)
		var/atom/movable/M = k
		if(M.qdeleting)
			log_error("Warning: Qdeleting object [M.get_debug_name()] was found in tracked ai avoidances.")
			avoidance_list -= k
			continue
		if(owner.z != M.z)
			log_error("Warning: Object [M.get_debug_name()] was found in a mismatched z-list in tracked ai avoidances.")
			avoidance_list -= k
			continue
		if(get_dist(M,owner) >= VIEW_RANGE*0.75)
			continue
		directions_to_avoid |= get_dir(owner,M)

	if(!directions_to_avoid)
		return FALSE

	var/good_direction = (NORTH | EAST | SOUTH | WEST) & ~directions_to_avoid

	if((good_direction & NORTH) && (good_direction && SOUTH))
		good_direction &= ~(prob(50) ? NORTH : SOUTH)

	if((good_direction & EAST) && (good_direction && WEST))
		good_direction &= ~(prob(50) ? EAST : WEST)

	if(debug)
		log_debug("Running away to the [dir2text(good_direction)] due to avoidance.")

	owner.move_dir = good_direction
	owner.movement_flags = MOVEMENT_RUNNING

	return TRUE

/ai/advanced/proc/find_nearby_weapon()
	var/list/possible_weapons = list()
	for(var/obj/item/weapon/W in view(VIEW_RANGE/2,owner))
		if(!W.z)
			continue
		var/weight_multiplier = 1
		if(istype(W,/obj/item/weapon/ranged/))
			var/obj/item/weapon/ranged/R = W
			if(!R.can_gun_shoot(owner,check_time=FALSE,messages=FALSE))
				continue
			weight_multiplier = 2
		if(istype(W,/obj/item/weapon/ranged/bullet/))
			var/obj/item/weapon/ranged/bullet/B = W
			if(!B.chambered_bullet)
				continue
			weight_multiplier = 3
		possible_weapons[W] = (max(1,(VIEW_RANGE + 1) - get_dist(owner,W.loc)))*weight_multiplier
	if(!length(possible_weapons))
		return null
	return pickweight(possible_weapons)

/ai/advanced/proc/handle_equipment() //Return true to avoid regular attack.

	var/mob/living/advanced/A = owner

	if(!found_grenade && !checked_grenades && objective_attack && prob(grenade_chance) && get_dist(owner,objective_attack) >= VIEW_RANGE*0.5)
		if(!find_grenade()) //Find a grenade to throw.
			checked_grenades = TRUE //Stop checking grenades as we can't find anymore.
		return TRUE

	if(found_grenade)
		if(!handle_grenade(found_grenade))
			found_grenade = null
		return TRUE

	if(found_ammo_pile) //Likely fleeing to an ammo pile. Probably. Hopefully.
		return TRUE

	if(should_find_weapon_on_ground && !A.left_item && !A.right_item && !objective_weapon)
		objective_weapon = find_nearby_weapon()
		if(!objective_weapon) checked_weapons_on_ground = TRUE

	if(istype(A.left_item,/obj/item/weapon/ranged/) && handle_gun(A.left_item))
		return TRUE

	if(istype(A.right_item,/obj/item/weapon/ranged/) && handle_gun(A.right_item))
		return TRUE




	return FALSE

/ai/advanced/proc/handle_grenade(var/obj/item/grenade/G)

	if(!G || !is_inventory(G.loc))
		return FALSE

	var/obj/hud/inventory/I = G.loc

	var/mob/living/advanced/A = owner
	if(!G.stored_trigger) //Bad grenade, doesn't even work. Drop it.
		G.drop_item(get_turf(A))
		return FALSE

	if(G.stored_trigger.active) //Live nade, throw it!
		var/atom/real_target = objective_attack
		if(real_target)
			var/turf/T = get_step(owner,real_target)
			if(T.density && (T.density_north || T.density_south || T.density_east || T.density_west))
				real_target = null
		if(!real_target)
			var/list/valid_turfs = list()
			for(var/turf/simulated/floor/F in view(VIEW_RANGE,A))
				if(get_dist(F,A) <= VIEW_RANGE*0.5)
					continue
				valid_turfs += F
			if(length(valid_turfs))
				real_target = pick(valid_turfs)

		if(real_target)
			var/list/offsets = get_directional_offsets(owner,real_target)
			var/throw_velocity = 10
			G.drop_item(get_turf(owner))
			G.throw_self(owner,real_target,16,16,offsets[1]*throw_velocity,offsets[2]*throw_velocity,lifetime = SECONDS_TO_DECISECONDS(4), steps_allowed = VIEW_RANGE, desired_loyalty_tag = owner.loyalty_tag)
		else
			G.drop_item(get_turf(A)) //Bad grenade. This will rarely happen due to the above turf checking but this is for weird cases.

		//The whole real_target checking multiple times seems ugly but what can you do.
		next_complex = world.time + rand(5,10)
		return FALSE
	else if(!I.click_flags) //The nade needs to be in our hands.
		if(!(A.left_item && A.right_item) || src.unequip_weapon(A.left_item) || src.unequip_weapon(A.right_item))
			A.put_in_hands(G)
		next_complex = world.time + rand(5,10)
		return TRUE
	else //Time to arm the grenade!
		G.click_self(A)
		next_complex = world.time + rand(5,30)
		return TRUE

/ai/advanced/proc/handle_gun(var/obj/item/weapon/ranged/R) //Handles all the reloading and other stuff.

	//Returning TRUE means don't attack on the same tick. It's good to return true if you want the shooter to wait before firing.

	var/mob/living/advanced/A = owner

	if(istype(R,/obj/item/weapon/ranged/bullet/magazine/))
		var/obj/item/weapon/ranged/bullet/magazine/G = R
		if(!G.stored_magazine && !G.chambered_bullet) //Find one
			if(G.wielded) //We should unwield
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
				next_complex = max(world.time,G.next_shoot_time) + rand(5,15)
				return TRUE
			var/obj/item/magazine/M
			var/obj/item/organ/O_groin = A.labeled_organs[BODY_GROIN]
			if(O_groin)
				M = recursive_find_item(O_groin,G,/obj/item/weapon/ranged/bullet/magazine/proc/can_fit_magazine)
			if(!M)
				if(!should_find_ammo_pile_on_empty || !find_ammo_pile())
					G.drop_item(get_turf(owner)) //IT'S NO USE. No magazines left.
				return TRUE
			M.click_on_object(A,G)
			if(!G.stored_magazine)
				G.drop_item(get_turf(owner)) //IT'S NO USE. Something went wrong with reloading the magazine.
				return TRUE
			if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !A.left_item)
				A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
				next_complex = max(world.time,G.next_shoot_time) + rand(2,6)
				return TRUE
			return TRUE

		if(G.stored_magazine && !length(G.stored_magazine.stored_bullets) && !G.chambered_bullet)
			G.eject_magazine(A)
			next_complex = max(world.time,G.next_shoot_time) + rand(10,20)
			return TRUE

		if(!G.chambered_bullet || G.chambered_bullet.is_spent)
			G.click_self(A)
			if(!G.chambered_bullet)
				G.drop_item(get_turf(owner)) //IT'S NO USE. Something went wrong with chambering the bullet.
				return FALSE
			next_complex = max(world.time,G.next_shoot_time) + rand(5,10)
			return TRUE

		return FALSE //All good.

	if(istype(R,/obj/item/weapon/ranged/bullet/revolver))
		var/obj/item/weapon/ranged/bullet/revolver/G = R
		if(!G.stored_bullets[G.current_chamber] || G.stored_bullets[G.current_chamber].is_spent || desired_shell_reload > 0)
			if(desired_shell_reload > 0)
				var/has_valid_bullet = FALSE
				for(var/k in G.stored_bullets)
					var/obj/item/bullet_cartridge/B = G.stored_bullets[k]
					if(!B || B.is_spent)
						continue
					has_valid_bullet = k
					break
				if(has_valid_bullet)
					G.rotate_cylinder(clamp(has_valid_bullet - G.current_chamber,-1,1)) //There is another valid bullet somewhere.
					next_complex = max(world.time,G.next_shoot_time) + rand(3,5)
					return TRUE

			if(G.wielded) //We should unwield
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
				next_complex = max(world.time,G.next_shoot_time) + rand(5,15)
				return TRUE

			if(!G.open)
				G.click_self(A) //Open it.
				next_complex = max(world.time,G.next_shoot_time) + rand(5,15)
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
				C.click_on_object(A,G)
				C.drop_item(get_turf(owner)) //We have no use for the clip; drop it.
				next_complex = max(world.time,G.next_shoot_time) + rand(5,10)
				return TRUE
			if(B)
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
				next_complex = max(world.time,G.next_shoot_time) + rand(2,5)
				return FALSE
			desired_shell_reload = 0
			if(!should_find_ammo_pile_on_empty || !find_ammo_pile())
				G.drop_item(get_turf(owner)) //Can't find anything, so drop it.
			return TRUE

		if(G.open && !G.can_shoot_while_open) //https://www.youtube.com/watch?v=ZiEGi2g1JkA
			G.click_self(A)
			next_complex = max(world.time,G.next_shoot_time) + rand(5,15)
			return TRUE

		desired_shell_reload = 0 //All good.
		if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !A.left_item)
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
			next_complex = max(world.time,G.next_shoot_time) + rand(2,6)
			return TRUE

		return FALSE

	if(istype(R,/obj/item/weapon/ranged/bullet/pump))
		var/obj/item/weapon/ranged/bullet/pump/G = R

		if((!G.chambered_bullet && G.stored_bullets[1]) || (G.chambered_bullet && G.chambered_bullet.is_spent))
			G.click_self(owner) //Chamber a new round in.
			next_complex = max(world.time,G.next_shoot_time) + rand(1,3)
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
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
				next_complex = max(world.time,G.next_shoot_time) + rand(5,15)
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
					G.drop_item(get_turf(owner)) //IT'S NO USE. Can't find any shells to put in.
				return FALSE
			B.click_on_object(A,G)
			next_complex = max(world.time,G.next_shoot_time) + rand(5,8)
			return TRUE

		desired_shell_reload = 0 //All good.
		if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !A.left_item)
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
			next_complex = max(world.time,G.next_shoot_time) + rand(5,8)
			return TRUE

		return FALSE

	return FALSE //Weird but okay

/ai/advanced/handle_movement()

	if(avoid_threats && handle_movement_avoidance())
		return TRUE

	if(handle_movement_weapon())
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
	var/obj/item/grenade/G = recursive_find_item(O_groin,src,.proc/is_grenade)
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
		if(istype(W,/obj/item/weapon/ranged/bullet/magazine/))
			var/obj/item/weapon/ranged/bullet/magazine/M = W
			if(!M.stored_magazine) continue
		var/weapon_value = (istype(W,/obj/item/weapon/ranged) && distance_check > 1 ? 4 : 1)
		weapon_value *= W.value
		if(!best_weapon || weapon_value > best_weapon_value)
			best_weapon = W
			best_weapon_value = weapon_value
			continue

	return best_weapon

/ai/advanced/proc/equip_weapon(var/obj/item/weapon/W)

	var/mob/living/advanced/A = owner

	. = FALSE

	if(A.inventories_by_id[BODY_HAND_RIGHT_HELD] && !A.right_item)
		A.inventories_by_id[BODY_HAND_RIGHT_HELD].add_object(W,FALSE)
		. = TRUE
		if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && W.can_wield && !W.wielded && !A.left_item)
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,W)

	else if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && !A.inventories_by_id[BODY_HAND_LEFT_HELD].parent_inventory && !A.left_item)
		A.inventories_by_id[BODY_HAND_LEFT_HELD].add_object(W,FALSE)
		. = TRUE

	if(. && istype(W,/obj/item/weapon/melee/energy))
		var/obj/item/weapon/melee/energy/E = W
		if(!E.enabled) E.click_self(A)

/ai/advanced/proc/unequip_weapon(var/obj/item/weapon/W)
	var/mob/living/advanced/A = owner
	if(istype(W,/obj/item/weapon/melee/energy))
		var/obj/item/weapon/melee/energy/E = W
		if(E.enabled) E.click_self(A)
	if(!W.quick_equip(A,ignore_hands=TRUE))
		W.drop_item(get_turf(owner))
	return TRUE

/ai/advanced/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	var/mob/living/advanced/A = owner

	if(new_alert_level == ALERT_LEVEL_COMBAT || new_alert_level == ALERT_LEVEL_CAUTION)
		if(!A.left_item && !A.right_item)
			var/obj/item/weapon/W = find_best_weapon(alert_source)
			if(W) equip_weapon(W)
	else if(new_alert_level == ALERT_LEVEL_NONE)
		if(A.right_item) unequip_weapon(A.right_item)
		if(A.left_item) unequip_weapon(A.left_item)

	return ..()

/ai/advanced/handle_attacking()

	var/mob/living/advanced/A = owner

	distance_target_min = 1
	distance_target_max = 1
	attack_distance_min = 1
	attack_distance_max = 1

	if(A.right_item && !A.left_item)
		left_click_chance = 100
		attack_distance_min = A.right_item.combat_range
		attack_distance_max = A.right_item.combat_range
	else if(!A.right_item && A.left_item)
		left_click_chance = 0
		attack_distance_min = A.left_item.combat_range
		attack_distance_max = A.left_item.combat_range
	else if(A.left_item && A.right_item)
		attack_distance_min = min(A.right_item.combat_range,A.left_item.combat_range)
		attack_distance_max = max(A.right_item.combat_range,A.left_item.combat_range)
		var/attack_distance_check = get_dist(owner,objective_attack)
		if(attack_distance_check <= A.right_item.combat_range && attack_distance_check <= A.left_item.combat_range)
			left_click_chance = 50
		else if(attack_distance_check <= A.right_item.combat_range)
			left_click_chance = 100
		else if(attack_distance_check <= A.left_item.combat_range)
			left_click_chance = 0

	distance_target_max = min(VIEW_RANGE,attack_distance_max)

	if(!checked_weapons && attack_distance_max == 1 && objective_attack && get_dist(owner,objective_attack) > 4) //Find a new weapon to use if our enemy is far.
		var/obj/item/weapon/W = find_best_weapon(objective_attack)
		if(W)
			if(A.right_item == W)
				return ..()
			if(A.left_item == W)
				return ..()
			if(A.right_item) unequip_weapon(A.right_item)
			if(A.left_item) unequip_weapon(A.left_item)
			equip_weapon(W)
		else
			checked_weapons = TRUE //Give up.

	if(next_complex > world.time)
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