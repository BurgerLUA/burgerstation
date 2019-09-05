/ai/advanced/
	name = "Advanced"
	desc = "AI for advanced mob types."

	radius_find_enemy = 8

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	target_distribution = list(0,8,8,16,16,16,32,32,32,32,64,64,64)

	sync_movement_delay = TRUE
	sync_attack_delay = FALSE
	simple = TRUE
	stationary = FALSE

	var/left_click_chance = 90

/ai/advanced/handle_attacking()

	var/is_left_click = prob(left_click_chance)
	var/weapon_distance = 1

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner

		var/obj/item/weapon_to_use = is_left_click ? A.get_held_right() : A.get_held_right()

		if(is_ranged_gun(weapon_to_use))
			weapon_distance = 100
		else if(is_melee(weapon_to_use))
			weapon_distance = 1

	if(objective_attack && get_dist(owner,objective_attack) <= weapon_distance)
		owner.move_dir = 0
		var/list/params = list(
			"icon-x" = num2text(pick(8,16,16,16,16,24)),
			"icon-y" = num2text(pick(target_distribution)),
			"left" = 0,
			"right" = 0,
			"middle" = 0,
			"ctrl" = 0,
			"shift" = 0,
			"alt" = 0
		)

		if(is_left_click)
			params["left"] = TRUE
			owner.on_left_down(objective_attack,owner,null,params)
		else
			params["right"] = TRUE
			owner.on_right_down(objective_attack,owner,null,params)

	attack_ticks = 0