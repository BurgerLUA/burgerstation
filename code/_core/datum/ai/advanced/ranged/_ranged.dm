/ai/advanced/ranged/

	left_click_chance = 100

	distance_target_min = VIEW_RANGE * 0.5
	distance_target_max = VIEW_RANGE + ZOOM_RANGE

/ai/advanced/ranged/handle_movement()

	if(objective_attack)
		if(get_dist(owner,objective_attack) > distance_target_max)
			owner.move_dir = get_dir(owner,objective_attack)
		else if(get_dist(owner,objective_attack) <= distance_target_min)
			owner.move_dir = get_dir(objective_attack,owner)
		else
			owner.move_dir = pick(list(0,0,0,0,turn(get_dir(owner,objective_attack),90),turn(get_dir(owner,objective_attack),-90)))

	else if(get_dist(owner,start_turf) >= 5)
		owner.move_dir = get_dir(owner,start_turf)
	else if(stationary)
		owner.move_dir = 0
	else
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))


/ai/advanced/ranged/can_attack(var/atom/target,var/left_click=FALSE)

	ranged_attack_cooldown = max(0,ranged_attack_cooldown - 1)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner
	if(!left_click)
		if(A.left_item && is_ranged_gun(A.left_item))
			if(can_fire_gun(A.left_item,target))
				return ..()
	else
		if(A.right_item && is_ranged_gun(A.right_item))
			if(can_fire_gun(A.right_item,target))
				return ..()

	return FALSE

/ai/advanced/ranged/proc/can_fire_gun(var/obj/item/weapon/ranged/R,var/atom/target)

	if(ranged_attack_cooldown > 0)
		return FALSE

	var/distance_mod = get_dist(owner,target)
	var/heat_limit = max(0,(1 - (distance_mod * 0.01)) * R.heat_max)

	return R.heat_current <= heat_limit

/ai/advanced/ranged/do_attack(var/atom/target,var/left_click=FALSE)

	. = ..()

	if(.)
		ranged_attack_cooldown = pick(TRUE,FALSE,FALSE,FALSE,FALSE) ? rand(10,20) : 0
		movement_delay = SECONDS_TO_TICKS(1)

	return .