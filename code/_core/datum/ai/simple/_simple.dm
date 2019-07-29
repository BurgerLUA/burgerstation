/ai/simple/
	name = "Simple AI"
	simple = TRUE

/ai/simple/handle_attacking()

	if(objective_attack && get_dist(owner,objective_attack) <= attack_distance)
		owner.move_dir = 0
		owner.attack(owner,objective_attack)

	attack_ticks = 0
