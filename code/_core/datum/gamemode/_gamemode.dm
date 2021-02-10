/gamemode/
	var/name = "Gamemode Name"
	var/desc = "Gamemode Description"

	var/objective/list/crew_active_objectives = list()
	var/objective/list/crew_completed_objectives = list()
	var/objective/list/crew_failed_objectives = list()

	var/objective/list/antagonist_active_objectives = list()
	var/objective/list/antagonist_completed_objectives = list()
	var/objective/list/antagonist_failed_objectives = list()

	var/allow_launch = FALSE

	var/state = GAMEMODE_PRELOAD

	var/list/objective_text = "No objectives listed."

	var/next_objective_update = 0

	var/round_time = 0 //In seconds.
	var/round_time_next = 120 //In seconds.

	var/hidden = FALSE //Set to true if this gamemode shouldn't show up in voting.

	var/points = 50
	//0 means failure.
	var/alert_level = CODE_GREEN

/gamemode/Destroy()

	QDEL_CUT(crew_active_objectives)
	QDEL_CUT(crew_completed_objectives)
	QDEL_CUT(crew_failed_objectives)

	QDEL_CUT(antagonist_active_objectives)
	QDEL_CUT(antagonist_completed_objectives)
	QDEL_CUT(antagonist_failed_objectives)

	return ..()

/gamemode/New()
	state = GAMEMODE_WAITING
	if(SSevents) //Go through all the events and remove them if needed. I know this is shitcode and I need to combine SSgamemode with SSevent so events initialize after the gamemode is picked.
		for(var/k in SSevents.all_events)
			var/event/E = SSevents.all_events[k]
			if(E.gamemode_blacklist[src.type])
				SSevents.all_events -= E.type
				qdel(E)
	return TRUE

/gamemode/proc/handle_alert_level()
	var/desired_alert_level = CODE_GREEN //Failsafe.
	switch(points)
		if(-INFINITY to 0)
			desired_alert_level = CODE_DELTA
		if(0 to 15)
			desired_alert_level = CODE_RED
		if(15 to 25)
			desired_alert_level = CODE_AMBER
		if(25 to 50)
			desired_alert_level = CODE_BLUE
		if(50 to INFINITY)
			desired_alert_level = CODE_GREEN

	if(desired_alert_level > alert_level)
		alert_level = desired_alert_level
		set_message("Code [alert_level]",TRUE)
		switch(alert_level)
			if(CODE_BLUE)
				CALLBACK_GLOBAL(\
					"gamemode_announce_alert",\
					SECONDS_TO_DECISECONDS(10),\
					.proc/announce,\
					"Station Alert System",\
					"Alert Level Increased",\
					"Attention. Condition Blue set throughout the station. Exercise Term: Fade Out.",\
					ANNOUNCEMENT_STATION,\
					'sound/voice/announcement/code_blue.ogg'\
				)
			if(CODE_AMBER)
				CALLBACK_GLOBAL(
					"gamemode_announce_alert",\
					SECONDS_TO_DECISECONDS(10),\
					.proc/announce,\
					"Station Alert System",\
					"Alert Level Increased",\
					"Attention. Condition Amber set throughout the station. Exercise Term: Double Take. Additional Enemy Reinforcements detected in route to Area of Operations.",\
					ANNOUNCEMENT_STATION,\
					'sound/voice/announcement/code_amber.ogg'\
				)
			if(CODE_RED)
				raid_station()
				CALLBACK_GLOBAL(\
					"gamemode_announce_alert",\
					SECONDS_TO_DECISECONDS(10),\
					.proc/announce,\
					"Station Alert System",\
					"Alert Level Increased",\
					"Warning. Warning. Condition Red set throughout the station. Exercise Term: Fast Pace. All personnel to prepare for potential borders on station..",\
					ANNOUNCEMENT_STATION,\
					'sound/voice/announcement/code_red.ogg'\
				)
			if(CODE_DELTA)
				CALLBACK_GLOBAL(\
					"gamemode_announce_alert",\
					SECONDS_TO_DECISECONDS(10),\
					.proc/announce,\
					"Station Alert System",\
					"Alert Level Increased",\
					"Warning. Warning. Condition Delta set throughout the station. Exercise Term: Cocked Pistol. Nuclear Strike is imminent. All personnel are ordered to evacuate the Area of Operations.",\
					ANNOUNCEMENT_STATION,\
					'sound/voice/announcement/code_delta.ogg'\
				)

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

	for(var/k in crew_active_objectives)
		var/objective/O = k
		objective_text += "[O.desc] (ACTIVE)<br>"

	for(var/k in crew_completed_objectives)
		var/objective/O = k
		objective_text += "[O.desc] (COMPLETED)<br>"

	for(var/k in crew_failed_objectives)
		var/objective/O = k
		objective_text += "[O.desc] (FAILED)<br>"

	for(var/k in all_objective_buttons)
		var/obj/hud/button/objectives/O = k
		O.set_stored_text(objective_text)

	announce("Central Command Mission Update","Objectives Updated",objective_text,ANNOUNCEMENT_STATION,'sound/alert/airplane.ogg')

	next_objective_update = -1

	return TRUE