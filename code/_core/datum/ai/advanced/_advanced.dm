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


/ai/advanced/can_attack(var/atom/target,var/left_click=FALSE)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner
	if(!left_click)
		if(A.left_item && is_ranged_gun(A.left_item))
			var/obj/item/weapon/ranged/R = A.left_item
			if(R.heat_current > R.automatic ? 0.05 : 0)
				return TRUE
	else
		if(A.right_item && is_ranged_gun(A.right_item))
			var/obj/item/weapon/ranged/R = A.right_item
			if(R.heat_current > R.automatic ? 0.05 : 0)
				return TRUE

	return FALSE