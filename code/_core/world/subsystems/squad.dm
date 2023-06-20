SUBSYSTEM_DEF(squad)
	name = "Squad Subsystem"
	desc = "Manages Squads"
	priority = SS_ORDER_FIRST
	tick_rate = SECONDS_TO_TICKS(1)

	tick_usage_max = 50

	var/list/squad/all_squads = list()

/subsystem/squad/unclog(var/mob/caller)

	for(var/k in all_squads)
		var/squad/S = k
		all_squads -= k
		if(!S || S.qdeleting)
			continue
		qdel(S)

	. = ..()

/subsystem/squad/Initialize()

	var/squad/red_team = new
	red_team.name = "Red Squad"
	red_team.never_delete = TRUE

	var/squad/blue_team = new
	blue_team.name = "Blue Squad"
	blue_team.never_delete = TRUE

	var/squad/yellow_team = new
	yellow_team.name = "Yellow Squad"
	yellow_team.never_delete = TRUE

	var/squad/green_team = new
	green_team.name = "Green Squad"
	green_team.never_delete = TRUE

	return ..()

/subsystem/squad/on_life()

	for(var/k in all_squads)
		var/squad/S = k
		if(!S || S.qdeleting)
			continue
		for(var/j in S.members)
			var/mob/living/advanced/player/M = j
			if(!M || M.qdeleting)
				continue
			M.update_squad_buttons()
			CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE