SUBSYSTEM_DEF(squad)
	name = "Squad Subsystem"
	desc = "Manages Squads"
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(1)

	tick_usage_max = 50
	cpu_usage_max = 50

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

	for(var/squad/S in all_squads)
		for(var/k in S.members)
			var/mob/living/advanced/player/M = k
			CHECK_TICK(tick_usage_max,FPS_SERVER)
			M.update_squad_buttons()

	return TRUE