SUBSYSTEM_DEF(poster)
	name = "Poster Subsystem"
	desc = "Handles the storing of collectable posters"
	priority = SS_ORDER_FIRST

	var/list/all_posters = list()

/subsystem/poster/Initialize()

	for(var/k in subtypesof(/collectable_poster/))
		var/collectable_poster/P = new k
		all_posters[P.type] = P

	return ..()
