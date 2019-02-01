var/global/list/all_factions = list()

/datum/subsystem/faction/
	name = "Faction Subsystem"
	desc = "Store all the factions."
	priority = SS_ORDER_FACTIONS

/datum/subsystem/faction/on_life()

	for(var/v in subtypesof(/faction/))
		var/faction/F = new v
		all_factions[F.id] = F

	return FALSE