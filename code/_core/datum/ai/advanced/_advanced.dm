/ai/advanced/

	var/should_find_weapon = TRUE //Set to true if you want this AI to find a weapon if it has none.
	var/checked_weapons = FALSE
	var/checked_grenades = FALSE

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

/ai/advanced/Destroy()
	objective_weapon = null
	return ..()

/ai/advanced/on_life()

	var/mob/living/advanced/A = owner
	if(resist_handcuffs && A.handcuffed && owner.next_resist <= world.time)
		owner.resist()

	return ..()

/ai/advanced/proc/handle_movement_weapon()

	if(!objective_weapon)
		return FALSE

	if(get_dist(owner,objective_weapon) > 1)
		owner.move_dir = get_dir(owner,objective_weapon)
		return TRUE

	equip_weapon(objective_weapon)

	return FALSE

/ai/advanced/proc/find_weapon_on_ground()

	var/mob/living/advanced/A = owner
	if(A.right_item || A.left_item || !should_find_weapon)
		return FALSE

	var/list/possible_items = list()
	for(var/obj/item/weapon/I in A.held_objects)
		possible_items += I
	for(var/obj/item/weapon/I in A.worn_objects)
		possible_items += I

	if(length(possible_items))
		var/obj/item/I = pick(possible_items)
		equip_weapon(I)
		return FALSE

	if(!objective_weapon || !isturf(objective_weapon.loc) || get_dist(A,objective_weapon.loc) > 6) //Find a wepapon on the ground.
		var/list/possible_weapons = list()
		for(var/obj/item/weapon/W in view(6,A))
			if(istype(W,/obj/item/weapon/ranged/))
				var/obj/item/weapon/ranged/R = W
				if(!R.firing_pin || R.firing_pin.iff_tag != A.iff_tag)
					continue
			if(istype(W,/obj/item/weapon/ranged/bullet/))
				var/obj/item/weapon/ranged/bullet/B = W
				if(!B.chambered_bullet)
					continue
			if(!isturf(W.loc))
				continue
			possible_weapons[W] = max(1,(6 + 1) - get_dist(A,W.loc))
		if(!length(possible_weapons))
			return FALSE
		objective_weapon = pickweight(possible_weapons)

	return TRUE

/ai/advanced/proc/handle_gunplay()
	var/mob/living/advanced/A = owner

	if(!checked_grenades)
		find_grenade()

	if(found_grenade && objective_attack && get_dist(owner,objective_attack) > 4 && prob(5))
		var/turf/T = get_step(A,get_dir(A,objective_attack))
		if(T.is_safe_teleport(TRUE))
			if(!handle_grenade(found_grenade))
				found_grenade = null
				checked_grenades = FALSE
			return TRUE
	if(istype(A.left_item,/obj/item/weapon/ranged/))
		if(!handle_gun(A.left_item))
			return FALSE
	if(istype(A.right_item,/obj/item/weapon/ranged/))
		if(!handle_gun(A.right_item))
			return FALSE

	return TRUE

/ai/advanced/proc/handle_grenade(var/obj/item/grenade/G)

	if(!G || !is_inventory(G.loc))
		return FALSE

	var/obj/hud/inventory/I = G.loc

	var/mob/living/advanced/A = owner
	if(!G.stored_trigger) //Bad grenad, doesn't even work. Drop it.
		G.drop_item(get_turf(A))
		return FALSE

	if(G.stored_trigger.active) //Live nade, throw it!
		var/atom/real_target = objective_attack
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
			G.throw_self(owner,real_target,16,16,offsets[1]*throw_velocity,offsets[2]*throw_velocity,lifetime = SECONDS_TO_DECISECONDS(4), steps_allowed = get_dist(owner,real_target), desired_loyalty_tag = owner.loyalty_tag)
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

/ai/advanced/proc/handle_gun(var/obj/item/weapon/ranged/R)

	//Returning FALSE means to don't shoot. It's good to return false if you want the shooter to wait before firing.

	var/mob/living/advanced/A = owner

	if(istype(R,/obj/item/weapon/ranged/bullet/magazine/))
		var/obj/item/weapon/ranged/bullet/magazine/G = R
		if(!G.stored_magazine && !G.chambered_bullet) //Find one
			if(G.wielded) //We should unwield
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
			next_complex = world.time + rand(15,30)
			var/obj/item/magazine/M
			var/obj/item/organ/O_groin = A.labeled_organs[BODY_GROIN]
			if(O_groin)
				M = recursive_find_item(O_groin,G,/obj/item/weapon/ranged/bullet/magazine/proc/can_fit_magazine)
			if(!M)
				G.drop_item(get_turf(owner)) //IT'S NO USE.
				return FALSE
			M.click_on_object(A,G)
			if(!G.stored_magazine)
				G.drop_item(get_turf(owner)) //IT'S NO USE.
				return FALSE
			if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !A.left_item)
				A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
				next_complex = world.time + rand(2,6)
			return FALSE

		if(G.stored_magazine && !length(G.stored_magazine.stored_bullets) && !G.chambered_bullet)
			G.eject_magazine(A)
			next_complex = world.time + rand(10,20)
			return FALSE

		if(!G.chambered_bullet || G.chambered_bullet.is_spent)
			G.click_self(A)
			if(!G.chambered_bullet)
				G.drop_item(get_turf(owner)) //IT'S NO USE.
				return FALSE
			next_complex = world.time + rand(5,10)
			return FALSE

		return TRUE

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
					next_complex = world.time + rand(3,5)
					return FALSE

			if(G.wielded) //We should unwield
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
				next_complex = world.time + rand(5,15)
				return FALSE

			if(!G.open)
				G.click_self(A) //Open it.
				next_complex = world.time + rand(5,15)
				return FALSE

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
				C.drop_item(get_turf(owner))
				next_complex = world.time + rand(5,10)
				return FALSE
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
				world.log << "Yeah: [desired_shell_reload]."
				next_complex = world.time + 1 //Honestly it takes like no time to insert it.
				return FALSE
			desired_shell_reload = -desired_shell_reload
			G.drop_item(get_turf(owner)) //IT'S NO USE.
			return FALSE

		if(G.open && !G.can_shoot_while_open) //https://www.youtube.com/watch?v=ZiEGi2g1JkA
			G.click_self(A)
			next_complex = world.time + rand(5,15)
			return FALSE

		desired_shell_reload = 0 //All good.
		if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !A.left_item)
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
			next_complex = world.time + rand(2,6)
			return FALSE

	if(istype(R,/obj/item/weapon/ranged/bullet/pump))
		var/obj/item/weapon/ranged/bullet/pump/G = R

		if((!G.chambered_bullet && G.stored_bullets[1]) || (G.chambered_bullet && G.chambered_bullet.is_spent))
			G.click_self(owner) //Chamber a new round in.
			next_complex = G.next_shoot_time + rand(1,3)
			return FALSE

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

		if(desired_shell_reload && !G.stored_bullets[desired_shell_reload])
			if(G.wielded) //We should unwield
				A.inventories_by_id[BODY_HAND_LEFT_HELD].unwield(A,G)
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
				G.drop_item(get_turf(owner)) //IT'S NO USE.
				return FALSE
			B.click_on_object(A,G)
			next_complex = world.time + rand(2,6)
			return FALSE

		desired_shell_reload = 0 //All good.
		if(A.inventories_by_id[BODY_HAND_LEFT_HELD] && G.can_wield && !G.wielded && !A.left_item)
			A.inventories_by_id[BODY_HAND_LEFT_HELD].wield(A,G)
			next_complex = world.time + rand(2,6)
			return FALSE

		return TRUE

	return TRUE

/ai/advanced/handle_movement()

	if(handle_movement_weapon())
		return TRUE

	. = ..()

/ai/advanced/do_attack(var/atom/target,var/left_click=FALSE)

	if(!target)
		return FALSE

	var/mob/living/advanced/A = owner

	if(!A)
		return FALSE

	if(next_complex > world.time)
		return FALSE

	if(!handle_gunplay())
		return FALSE

	var/list/params = list(
		PARAM_ICON_X = "16",
		PARAM_ICON_Y = "16",
		"left" = 0,
		"right" = 0,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	if(left_click && A.inventories_by_id[BODY_HAND_RIGHT_HELD])
		A.inventories_by_id[BODY_HAND_RIGHT_HELD].click_on_object(A,target,null,null,params)
	else if (A.inventories_by_id[BODY_HAND_LEFT_HELD])
		A.inventories_by_id[BODY_HAND_LEFT_HELD].click_on_object(A,target,null,null,params)
	else if (A.labeled_organs[BODY_HEAD])
		A.labeled_organs[BODY_HEAD].attack(A,target,params)

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

	checked_grenades = TRUE

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

	if(!checked_weapons && attack_distance_max == 1 && objective_attack && get_dist(owner,objective_attack) > 4)
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

	. = ..()