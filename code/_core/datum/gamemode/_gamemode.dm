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

/gamemode/proc/can_continue()
	//Can we even continue?
	return TRUE

/gamemode/proc/add_objective(var/objective/O)
	O = new O

	if(O.completion_state == IMPOSSIBLE)
		qdel(O)

	if(!O || O.qdeleting)
		log_error("Could not add objective [O.type].")
		return FALSE
	next_objective_update = world.time + 10
	O.update()
	return TRUE

/gamemode/proc/update_objectives()

	objective_text = ""

	for(var/k in active_objectives)
		var/objective/O = k
		objective_text += "[O.desc] (ACTIVE)<br>"

	for(var/k in completed_objectives)
		var/objective/O = k
		objective_text += "[O.desc] (COMPLETED)<br>"

	for(var/k in failed_objectives)
		var/objective/O = k
		objective_text += "[O.desc] (FAILED)<br>"

	for(var/k in all_objective_buttons)
		var/obj/hud/button/objectives/O = k
		O.set_stored_text(objective_text)

	announce("Central Command Update","Objectives Updated",objective_text,ANNOUNCEMENT_STATION,'sound/voice/station/new_command_report.ogg')

	next_objective_update = -1

	return TRUE