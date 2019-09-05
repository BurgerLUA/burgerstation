/ai/passive
	name = "Passive AI"
	desc = "Does not attack unless provoked. Usually very slow."

	radius_find_enemy = 3

	objective_delay = 20
	attack_delay = 1
	movement_delay = 0

	target_distribution = list(8,8,8,8,16,32)

	simple = TRUE
	sync_attack_delay = TRUE
	sync_movement_delay = TRUE

	stationary = FALSE

/ai/passive/handle_attacking()

	if(objective_attack && get_dist(owner,objective_attack) <= 1)
		owner.move_dir = 0
		owner.attack(owner,objective_attack)

	attack_ticks = 0