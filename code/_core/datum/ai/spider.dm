/ai/spider
	name = "Spider"
	desc = "Spider bites and whatnot."

	radius_find_enemy = 8

	objective_delay = 10
	attack_delay = 1
	movement_delay = 0

	target_distribution = list(8,8,8,8,16,32)

	simple = TRUE

	sync_stats = TRUE

/ai/spider/handle_attacking()

	if(attack_ticks < attack_delay)
		attack_ticks += 1
		return

	if(objective_attack && get_dist(owner,objective_attack) <= 1)
		owner.move_dir = 0
		owner.attack(owner,objective_attack)

	attack_ticks = 0

/ai/spider/handle_movement()
	..()