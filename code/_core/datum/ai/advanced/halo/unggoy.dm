/ai/advanced/halo/unggoy
	enemy_tags = list("NanoTrasen","Syndicate")
	should_find_weapon = TRUE
	aggression = 1
	retaliate = TRUE




/ai/advanced/halo/unggoy/stress_test

/ai/advanced/halo/unggoy/stress_test/handle_movement()
	owner.move_dir = pick(DIRECTIONS_ALL)
	return TRUE

/ai/advanced/halo/unggoy/lobby
	active = TRUE