var/global/list/all_factions = list()

/subsystem/faction/
	name = "Faction Subsystem"
	desc = "Store all the factions."
	priority = SS_ORDER_NORMAL

/subsystem/faction/Initialize()
	for(var/v in subtypesof(/faction/))
		var/faction/F = new v
		all_factions[F.id] = F

	LOG_SERVER("Initialized [length(all_factions)] factions.")