/ai/wizard/
	name = "Wizard"

	sync_stats = TRUE
	stationary = FALSE

/ai/wizard/hostile_message()
	owner.say("Ohohoho! Someone challenges me?")

/ai/wizard/handle_attacking()

	if(attack_ticks < attack_delay)
		attack_ticks += 1
		return

	if(objective_attack && get_dist(owner,objective_attack) <= 8)
		owner.move_dir = 0
		var/list/params = list(
			"icon-x" = num2text(16),
			"icon-y" = num2text(pick(target_distribution)),
			"left" = 0,
			"right" = 0,
			"middle" = 0,
			"ctrl" = 0,
			"shift" = 0,
			"alt" = 0
		)

		if(prob(75))
			params["right"] = TRUE
			owner.on_right_down(objective_attack,owner,null,params)
		else
			params["left"] = TRUE
			owner.on_left_down(objective_attack,owner,null,params)


	attack_ticks = 0


/ai/wizard/handle_movement()

	if(movement_ticks < movement_delay)
		movement_ticks += 1
		return

	if(objective_attack)

		if(get_dist(owner,objective_attack) > 8)
			owner.move_dir = get_dir(owner,objective_attack)
		else if(get_dist(owner,objective_attack) <= 4)
			owner.move_dir = reverse_direction(get_dir(owner,objective_attack))
		else
			owner.move_dir = 0

	else if(get_dist(owner,start_turf) >= 5)
		owner.move_dir = get_dir(owner,start_turf)
	else if(stationary)
		owner.move_dir = 0
	else
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))

	movement_ticks = 0