/gamemode/
	var/name = "Gamemode Name"
	var/desc = "Gamemode Description"

	var/objective/list/active_objectives = list()
	var/objective/list/completed_objectives = list()
	var/objective/list/failed_objectives = list()

	var/allow_launch = FALSE

	var/state = GAMEMODE_PRELOAD

	var/list/objective_text = "No objectives listed."

	var/next_objective_update = 0

	var/round_time = 0 //In seconds.
	var/round_time_next = 120 //In seconds.

	var/hidden = FALSE //Set to true if this gamemode shouldn't show up in voting.

/gamemode/Destroy()
	active_objectives.Cut()
	completed_objectives.Cut()
	failed_objectives.Cut()
	return ..()

/gamemode/New()
	state = GAMEMODE_WAITING
	return TRUE

/gamemode/proc/on_life()

	if(next_objective_update > 0 && next_objective_update <= world.time)
		update_objectives()

	round_time++

	return TRUE

/gamemode/proc/on_end()
	state = GAMEMODE_BREAK
	return TRUE

/gamemode/proc/on_continue() //What to do when this gamemode continues via a vote.
	state = GAMEMODE_FIGHTING
	return TRUE

/gamemode/proc/add_objective(var/objective/O)
	O = new O
	if(!O || O.qdeleting)
		log_error("Could not add objective [O.type].")
		return FALSE
	next_objective_update = world.time + 10
	O.update()
	return TRUE

/gamemode/proc/update_objectives()

	objective_text = ""

	for(var/objective/O in active_objectives)
		objective_text += "[O.desc] (ACTIVE)<br>"

	for(var/objective/O in completed_objectives)
		objective_text += "[O.desc] (COMPLETED)<br>"

	for(var/objective/O in failed_objectives)
		objective_text += "[O.desc] (FAILED)<br>"

	for(var/obj/hud/button/objectives/O in all_objective_buttons)
		O.set_stored_text(objective_text)

	announce("Central Command Update","Objectives Updated",objective_text,ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')

	next_objective_update = -1

	return TRUE