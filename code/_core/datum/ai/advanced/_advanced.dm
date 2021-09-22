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

	roaming_distance = 0

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
				if(!R.firing_pin || R.firing_pin != A.iff_tag)
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

	if(found_grenade && objective_attack && prob(5))
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
			var/list/offsets = direction_to_pixel_offset(get_dir(owner,real_target))
			var/throw_velocity = 10
			G.drop_item(get_turf(owner))
			G.throw_self(owner,real_target,16,16,offsets[1]*throw_velocity,offsets[2]*throw_velocity,lifetime = SECONDS_TO_DECISECONDS(4), steps_allowed = get_dist(owner,real_target), desired_iff = owner.iff_tag)
		next_complex = world.time + 5
		return FALSE
	else if(!I.click_flags) //The nade needs to be in our hands.
		if(!(A.left_item && A.right_item) || src.unequip_weapon(A.left_item) || src.unequip_weapon(A.right_item))
			A.put_in_hands(G)
		next_complex = world.time + 10
		return TRUE
	else //Time to arm the grenade!
		G.click_self(A)
		next_complex = world.time + 20
		return TRUE

/ai/advanced/proc/handle_gun(var/obj/item/weapon/ranged/R)

	var/mob/living/advanced/A = owner

	if(istype(R,/obj/item/weapon/ranged/bullet/magazine/))
		var/obj/item/weapon/ranged/bullet/magazine/G = R
		if(!G.stored_magazine && !G.chambered_bullet) //Find one
			if(G.wielded) //We should unwield
				A.left_hand.unwield(A,G)
			next_complex = world.time + 15
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
			if(G.can_wield && !G.wielded && A.left_hand && !A.left_item)
				A.left_hand.wield(A,G)
			return FALSE

		if(G.stored_magazine && !length(G.stored_magazine.stored_bullets) && !G.chambered_bullet)
			G.eject_magazine(A)
			next_complex = world.time + 10
			return FALSE

		if(!G.chambered_bullet || G.chambered_bullet.is_spent)
			G.click_self(A)
			if(!G.chambered_bullet)
				unequip_weapon(G)
				return FALSE
			next_complex = world.time + 5
			return FALSE

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
		PARAM_ICON_X = num2text(pick(target_distribution_x)),
		PARAM_ICON_Y = num2text(pick(target_distribution_y)),
		"left" = 0,
		"right" = 0,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	if(left_click && A.right_hand)
		A.right_hand.click_on_object(A,target,null,null,params)
	else if(A.left_hand)
		A.left_hand.click_on_object(A,target,null,null,params)

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

	if(A.right_hand && !A.right_item)
		A.right_hand.add_object(W,FALSE)
		. = TRUE
		if(W.can_wield && !W.wielded && A.left_hand && !A.left_item)
			A.left_hand.wield(A,W)

	else if(A.left_hand && !A.left_hand.parent_inventory && !A.left_item)
		A.left_hand.add_object(W,FALSE)
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

	if(A.right_item && A.left_item)
		left_click_chance = 50
		if(is_ranged_gun(A.right_item))
			distance_target_min = VIEW_RANGE * 0.5
			distance_target_max = VIEW_RANGE + ZOOM_RANGE
			attack_distance_min = VIEW_RANGE * 0.5
			attack_distance_max = VIEW_RANGE * 0.75
			if(!is_ranged_gun(A.left_item))
				left_click_chance = 100
		else if(is_ranged_gun(A.left_item))
			distance_target_min = VIEW_RANGE * 0.5
			distance_target_max = VIEW_RANGE + ZOOM_RANGE
			attack_distance_min = VIEW_RANGE * 0.5
			attack_distance_max = VIEW_RANGE * 0.75
			left_click_chance = 0
	else if(A.right_item)
		left_click_chance = 100
		if(is_ranged_gun(A.right_item))
			distance_target_min = VIEW_RANGE * 0.5
			distance_target_max = VIEW_RANGE + ZOOM_RANGE
			attack_distance_min = VIEW_RANGE * 0.5
			attack_distance_max = VIEW_RANGE * 0.75
	else if(A.left_item)
		left_click_chance = 0
		if(is_ranged_gun(A.left_item))
			distance_target_min = VIEW_RANGE * 0.5
			distance_target_max = VIEW_RANGE + ZOOM_RANGE
			attack_distance_min = VIEW_RANGE * 0.5
			attack_distance_max = VIEW_RANGE * 0.75

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

	return ..()