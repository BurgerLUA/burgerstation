/objective/kill_boss
	name = "Kill Boss"
	desc = "Kill \the #TARGET located at #LOCATION."

/objective/kill_boss/get_valid_targets()
	return SSbosses.living_bosses

/objective/kill_boss/start()

	tracked_atoms += get_random_target()

	update()

	return ..()