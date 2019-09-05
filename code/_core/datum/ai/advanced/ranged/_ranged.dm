/ai/advanced/ranged/
	name = "Advanced Ranged AI"

	left_click_chance = 100

	var/distance_target_min = 4
	var/distance_target_max = 8

/ai/advanced/ranged/handle_movement()

	if(objective_attack)
		if(get_dist(owner,objective_attack) > distance_target_max)
			owner.move_dir = get_dir(owner,objective_attack)
		else if(get_dist(owner,objective_attack) <= distance_target_min)
			var/desired_direction = get_dir(objective_attack,owner)
			owner.move_dir = desired_direction
		else
			owner.move_dir = 0

	else if(get_dist(owner,start_turf) >= 5)
		owner.move_dir = get_dir(owner,start_turf)
	else if(stationary)
		owner.move_dir = 0
	else
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))
