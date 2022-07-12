/ai/advanced/syndicate
	enemy_tags = list("NanoTrasen")
	should_find_weapon = TRUE
	aggression = 1
	cowardice = 0.5
	retaliate = TRUE




/ai/advanced/syndicate/stress_test

/ai/advanced/syndicate/stress_test/handle_movement()
	owner.move_dir = pick(DIRECTIONS_ALL)
	return TRUE




/ai/advanced/slavic
	language_to_use = LANGUAGE_SLAVIC
	enemy_tags = list("NanoTrasen")
	should_find_weapon = TRUE
	aggression = 1
	cowardice = 0.25
	retaliate = TRUE

