/objective/
	var/name = "Objective Name"
	var/desc = "Objective Description"
	var/atom/list/tracked_atoms = list()
	var/completion_state = ACTIVE
	var/credit_reward = 0
	var/burgerbux_reward = 0
	var/points_reward = 0

	var/antagonist = FALSE

	var/trackable = TRUE

/objective/New()

	if(!setup() || !start())
		completion_state = IMPOSSIBLE

	return ..()

/objective/proc/setup() //Do any setup required to make this objective work.
	return TRUE

/objective/proc/start()
	return TRUE

/objective/proc/on_gamemode_playable()
	return TRUE

/objective/proc/on_completion()

	if(credit_reward)
		for(var/k in all_players)
			var/mob/living/advanced/player/P = k
			if(P.loyalty_tag != "NanoTrasen")
				continue
			var/increased_currency = P.adjust_currency(credit_reward)
			P.to_chat(span("notice","You've been given [increased_currency] credits for completing [name]."))

		credit_reward = 0

	if(burgerbux_reward)
		for(var/k in all_players)
			var/mob/living/advanced/player/P = k
			if(P.loyalty_tag != "NanoTrasen")
				continue
			var/increased_currency = P.adjust_burgerbux(burgerbux_reward)
			P.to_chat(span("notice","You've been given [increased_currency] burgerbux for completing [name]."))

		burgerbux_reward = 0

	if(points_reward)
		SSgamemode.active_gamemode.points += points_reward
		points_reward = 0

	return TRUE

/objective/proc/check_completion()
	return ACTIVE

/objective/proc/get_locations()
	. = list()

	for(var/k in tracked_atoms)
		var/atom/A = k
		var/area/A2 = get_area(A)
		if(A2) . += A2

	return .

/objective/proc/get_description()
	return "[initial(desc)] ([completion_state])"

/objective/proc/update(var/update_gamemode = TRUE)

	var/gamemode/G = SSgamemode.active_gamemode

	var/old_completion_state = completion_state
	completion_state = check_completion()

	G.crew_active_objectives -= src
	G.crew_completed_objectives -= src
	G.crew_failed_objectives -= src

	G.antagonist_active_objectives -= src
	G.antagonist_completed_objectives -= src
	G.antagonist_failed_objectives -= src

	if(antagonist)
		switch(completion_state)
			if(ACTIVE)
				G.antagonist_active_objectives |= src
			if(COMPLETED)
				G.antagonist_completed_objectives |= src
			if(FAILED)
				G.antagonist_failed_objectives |= src
	else
		switch(completion_state)
			if(ACTIVE)
				G.crew_active_objectives |= src
			if(COMPLETED)
				G.crew_completed_objectives |= src
			if(FAILED)
				G.crew_failed_objectives |= src

	desc = get_description()

	. = (old_completion_state != completion_state)

	if(. && update_gamemode)
		G.next_objective_update = world.time + 50
		if(completion_state == COMPLETED)
			on_completion()

	return .