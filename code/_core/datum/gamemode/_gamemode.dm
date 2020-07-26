/gamemode/
	var/name = "Gamemode Name"
	var/desc = "Gamemode Description"

	var/objective/list/active_objectives = list()
	var/objective/list/completed_objectives = list()
	var/objective/list/failed_objectives = list()

	var/list/allowed_shuttles = list() //What shuttles are allowed to launch.

	var/state = GAMEMODE_PRELOAD

	var/list/objective_text_list = list()

	var/next_objective_update = 0

	var/round_time = 0 //In seconds.
	var/round_time_next = 120 //In seconds.

	var/hidden = FALSE //Set to true if this gamemode shouldn't show up in voting.

/gamemode/Destroy()
	active_objectives.Cut()
	completed_objectives.Cut()
	failed_objectives.Cut()
	allowed_shuttles.Cut()
	return ..()

/gamemode/New()
	state = GAMEMODE_WAITING
	round_time_next = initial(round_time_next)
	return TRUE

/gamemode/proc/on_life()

	if(next_objective_update && next_objective_update <= world.time)
		update_objectives()

	round_time++

	return TRUE

/gamemode/proc/on_end()
	state = GAMEMODE_BREAK
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