/gamemode/
	var/name = "Gamemode Name"
	var/desc = "Gamemode Description"

	var/objective/list/active_objectives = list()
	var/objective/list/completed_objectives = list()
	var/objective/list/failed_objectives = list()

	var/list/allowed_shuttles = list() //What shuttles are allowed to launch.

	var/state = GAMEMODE_INITIALIZING

	var/list/objective_text_list = list()

	var/next_objective_update = 0

/gamemode/proc/on_start()
	state = GAMEMODE_SETUP
	return TRUE

/gamemode/proc/on_life()

	if(next_objective_update && next_objective_update <= world.time)
		update_objectives()

	return TRUE

/gamemode/proc/on_end()
	state = GAMEMODE_ENDING
	return TRUE

/gamemode/proc/update_objectives()

	objective_text_list = list()

	for(var/objective/O in active_objectives)
		objective_text_list += O.desc

	for(var/objective/O in completed_objectives)
		objective_text_list += O.desc

	for(var/objective/O in failed_objectives)
		objective_text_list += O.desc

	return TRUE