/ai/advanced/

	radius_find_enemy = VIEW_RANGE + ZOOM_RANGE

	objective_delay = 10
	attack_delay = 1

	target_distribution_y = list(0,8,8,16,16,16,32,32,32,32,64,64,64)

	stationary = FALSE

	//var/ranged_attack_cooldown = 0

	var/checked_weapons = FALSE

	var/obj/hud/inventory/old_left_hand_inventory
	var/obj/hud/inventory/old_right_hand_inventory
	var/obj/item/weapon/objective_weapon


	var/attack_delay_left
	var/attack_delay_right

/ai/advanced/Destroy()
	old_left_hand_inventory = null
	old_right_hand_inventory = null
	objective_weapon = null
	return ..()

/ai/advanced/proc/handle_movement_weapon()

	if(!is_advanced(owner))
		return FALSE

	var/mob/living/advanced/A = owner
	if(A.right_item || A.left_item)
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
	else
		A.right_hand.add_held_object(objective_weapon,FALSE)
		objective_weapon.click_self(A)

	return FALSE


/ai/advanced/handle_movement()

	if(handle_movement_weapon())
		return TRUE

	if(locate(/obj/structure/interactive/barricade) in owner.loc.contents)
		return TRUE

	return ..()


/ai/advanced/do_attack(var/atom/target,var/left_click=FALSE)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	var/atom/defer_right = A.right_hand?.defer_click_on_object()
	var/atom/defer_left = A.left_hand?.defer_click_on_object()

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

	if(!defer_right || !owner.can_attack(target,defer_right,params))
		defer_right = null
		left_click = FALSE

	if(!defer_left || !owner.can_attack(target,defer_left,params))
		defer_left = null
		left_click = TRUE

	if(!defer_right && !defer_left)
		return FALSE

	var/atom/attacking_atom = left_click ? defer_right : defer_left
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


/ai/advanced/handle_attacking()

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	if(objective_attack)
		if(!A.left_item && !A.right_item)
			var/list/possible_weapons = list()
			for(var/obj/item/weapon/W in A.worn_objects)
				possible_weapons[W] = W.calculate_value()
			for(var/obj/item/weapon/W in A.held_objects)
				possible_weapons[W] = W.calculate_value()
			if(length(possible_weapons))
				var/obj/item/weapon/W = pickweight(possible_weapons)
				if(A.right_hand)
					old_right_hand_inventory = W.loc
					A.right_hand.add_held_object(W,FALSE)
				else if(A.left_hand)
					old_left_hand_inventory = W.loc
					A.left_hand.add_held_object(W,FALSE)
				W.click_self(A)
	else
		if(old_right_hand_inventory && A.right_item)
			old_right_hand_inventory.add_worn_object(A.right_item,FALSE)
			old_right_hand_inventory = null

		if(old_left_hand_inventory && A.left_item)
			old_left_hand_inventory.add_worn_object(A.left_item,FALSE)
			old_left_hand_inventory = null

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