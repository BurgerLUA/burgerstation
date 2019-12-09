/subsystem/squad/
	name = "Squad Subsystem"
	desc = "Manages Squads"
	priority = SS_ORDER_PRELOAD

/subsystem/spellcrafing/Initialize()

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

	return TRUE