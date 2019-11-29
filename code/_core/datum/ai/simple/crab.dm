/ai/simple/crab
	name = "Aggressive Crab"
	desc = "Seems smarter and deadlier than normal crabs."

	radius_find_enemy = 12
	attack_distance = 1

	objective_delay = 10
	attack_delay = 1
	movement_delay = 1

	target_distribution_x = list(0,8)
	target_distribution_y = list(0)

	sync_attack_delay = TRUE
	sync_movement_delay = TRUE
	simple = TRUE

/ai/simple/king_crab
	name = "King Crab"
	desc = "Seems smarter and deadlier than normal crabs."

	radius_find_enemy = 10

	objective_delay = 4
	attack_delay = 1
	movement_delay = 1

	target_distribution_y = list(8,8,8,8,16,32)

	sync_attack_delay = TRUE
	sync_movement_delay = TRUE
	simple = TRUE
