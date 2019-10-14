/ai/passive
	name = "Passive AI"
	desc = "Does not attack unless provoked. Usually very slow."

	radius_find_enemy = 3

	objective_delay = 20
	attack_delay = 1
	movement_delay = 0

	target_distribution_y = list(8,8,8,8,16,32)

	simple = TRUE
	sync_attack_delay = TRUE
	sync_movement_delay = TRUE

	stationary = FALSE


/ai/passive/crab

	name = "Non-Aggressive Crab"

	target_distribution_x = list(0,8)
	target_distribution_y = list(0)