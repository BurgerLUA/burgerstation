/ai/advanced/

	radius_find_enemy = VIEW_RANGE

	objective_delay = 10
	attack_delay = 1

	target_distribution_y = list(0,8,8,16,16,16,32,32,32,32,64,64,64)

	stationary = FALSE

	var/should_find_weapon = TRUE //Set to true if you want this AI to find a weapon if it has none.
	var/checked_weapons = FALSE

	var/obj/item/weapon/objective_weapon
	var/attack_delay_left
	var/attack_delay_right

/ai/advanced/Destroy()
	objective_weapon = null
	return ..()

/ai/advanced/proc/handle_movement_weapon()

	if(!is_advanced(owner))
		return FALSE

	var/mob/living/advanced/A = owner
	if(A.right_item || A.left_item || !should_find_weapon)
		return FALSE

	var/list/possible_items = list()
	for(var/obj/item/I in A.held_objects)
		if(istype(I,/obj/item/weapon/))
			possible_items += I

	if(length(possible_items))
		var/obj/item/I = pick(possible_items)
		A.right_hand.add_held_object(I,FALSE)
		I.click_self(A)
		return FALSE

	if(!objective_weapon || !isturf(objective_weapon.loc) || get_dist(A,objective_weapon.loc) > 6)
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
			possible_weapons[W] = (6 + 1) - get_dist(A,W.loc)
		if(!length(possible_weapons))
			return FALSE
		objective_weapon = pickweight(possible_weapons)

	if(get_dist(A,objective_weapon) > 1)
		A.move_dir = get_dir(owner,objective_weapon)
		return TRUE

	A.right_hand.add_held_object(objective_weapon,FALSE)
	objective_weapon.click_self(A)

	return FALSE


/ai/advanced/handle_movement()

	if(handle_movement_weapon())
		return TRUE

	return ..()


/ai/advanced/do_attack(var/atom/target,var/left_click=FALSE)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

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

	var/atom/defer_right_click = A.left_hand?.defer_click_on_object(null,null,params)
	var/atom/defer_left_click = A.right_hand?.defer_click_on_object(null,null,params)

	if(!defer_right_click || !owner.can_attack(target,defer_right_click,params,null))
		defer_right_click = null
		left_click = TRUE

	if(!defer_left_click || !owner.can_attack(target,defer_left_click,params,null))
		defer_left_click = null
		left_click = FALSE

	if(!defer_right_click && !defer_left_click)
		return FALSE

	var/atom/attacking_atom = left_click ? defer_left_click : defer_right_click
	return attacking_atom.click_on_object(owner,target,null,null,params)


/*
/ai/advanced/can_attack(var/atom/target,var/left_click=FALSE)

	ranged_attack_cooldown = max(0,ranged_attack_cooldown - 1)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner
	if(!left_click)
		if(A.left_item && is_ranged_gun(A.left_item) && !can_fire_gun(A.left_item,target))
			return FALSE
	else
		if(A.right_item && is_ranged_gun(A.right_item) && !can_fire_gun(A.right_item,target))
			return FALSE

	return ..()

/ai/advanced/proc/can_fire_gun(var/obj/item/weapon/ranged/R,var/atom/target)

	if(ranged_attack_cooldown > 0)
		return FALSE

	var/distance_mod = get_dist(owner,target)
	var/heat_limit = max(0,(1 - (distance_mod * 0.01)) * R.heat_max)

	return R.heat_current <= heat_limit


/ai/advanced/do_attack(var/atom/target,var/left_click=FALSE)

	. = ..()

	if(.)
		ranged_attack_cooldown = pick(TRUE,FALSE,FALSE,FALSE,FALSE) ? rand(10,20) : 0

	return .
*/


/ai/advanced/on_alert_level_changed(var/old_alert_level,var/new_alert_level)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	if(new_alert_level == ALERT_LEVEL_ALERT || new_alert_level == ALERT_LEVEL_CAUTION)
		if(!A.left_item && !A.right_item)
			var/list/possible_weapons = list()
			for(var/obj/item/weapon/W in A.worn_objects)
				possible_weapons[W] = W.calculate_value()
			for(var/obj/item/weapon/W in A.held_objects)
				possible_weapons[W] = W.calculate_value()
			if(length(possible_weapons))
				var/obj/item/weapon/W = pickweight(possible_weapons)
				if(A.right_hand)
					A.right_hand.add_held_object(W,FALSE)
				else if(A.left_hand)
					A.left_hand.add_held_object(W,FALSE)
				W.click_self(A)
	else
		if(A.right_item)
			A.right_item.quick_equip(A)

		if(A.left_item)
			A.left_item.quick_equip(A)

	return ..()

/ai/advanced/handle_attacking()

	if(!is_advanced(owner))
		return ..()

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
			attack_distance_min = 1
			attack_distance_max = 8
			if(!is_ranged_gun(A.left_item))
				left_click_chance = 100
		else if(is_ranged_gun(A.left_item))
			distance_target_min = VIEW_RANGE * 0.5
			distance_target_max = VIEW_RANGE + ZOOM_RANGE
			attack_distance_min = 1
			attack_distance_max = 8
			left_click_chance = 0
	else if(A.right_item)
		left_click_chance = 100
		if(is_ranged_gun(A.right_item))
			distance_target_min = VIEW_RANGE * 0.5
			distance_target_max = VIEW_RANGE + ZOOM_RANGE
			attack_distance_min = 1
			attack_distance_max = 8
	else if(A.left_item)
		left_click_chance = 0
		if(is_ranged_gun(A.left_item))
			distance_target_min = VIEW_RANGE * 0.5
			distance_target_max = VIEW_RANGE + ZOOM_RANGE
			attack_distance_min = 1
			attack_distance_max = 8

	return ..()