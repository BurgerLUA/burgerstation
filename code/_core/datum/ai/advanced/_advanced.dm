/ai/advanced/

	radius_find_enemy = 8

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	target_distribution_y = list(0,8,8,16,16,16,32,32,32,32,64,64,64)

	sync_movement_delay = TRUE
	sync_attack_delay = FALSE
	simple = TRUE
	stationary = FALSE

	var/ranged_attack_cooldown = 0

/ai/advanced/can_attack(var/atom/target,var/left_click=FALSE)

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
		movement_delay = SECONDS_TO_TICKS(1)

	return .