/ai/crab
	name = "Aggressive Crab"
	desc = "Seems smarter and deadlier than normal crabs."

	radius_find_enemy = 12

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	target_distribution = list(8,8,8,8,16,32)

	simple = TRUE

	sync_stats = TRUE

/ai/crab/handle_attacking()

	if(objective_attack && get_dist(owner,objective_attack) <= 1)
		owner.move_dir = 0
		owner.attack(owner,objective_attack)

	attack_ticks = 0


/ai/king_crab
	name = "King Crab"
	desc = "Seems smarter and deadlier than normal crabs."

	radius_find_enemy = 8

	objective_delay = 4
	attack_delay = 1
	movement_delay = 1

	target_distribution = list(8,8,8,8,16,32)

	simple = TRUE

	sync_stats = TRUE

/ai/king_crab/handle_attacking()

	if(objective_attack && get_dist(owner,objective_attack) <= 2)
		owner.move_dir = 0
		owner.attack(owner,objective_attack)

	attack_ticks = 0