/SUBSYSTEM_DEF(stats)
	name = "Stats"
	desc = "Tracks stats and other records for the round and game."
	priority = SS_ORDER_PRELOAD

	var/nanotrasen_kills = 0
	var/nanotrasen_deaths = 0

	var/antag_kills = 0
	var/antag_deaths = 0

	var/other_kills = 0
	var/other_deaths = 0

	var/list/stored_stats = list()

/subsystem/stats/Initialize()
	return ..()