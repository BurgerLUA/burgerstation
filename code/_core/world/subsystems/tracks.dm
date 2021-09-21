SUBSYSTEM_DEF(track)
	name = "Track Subsystem"
	desc = "Stores all the known musical tracks in a list."
	priority = SS_ORDER_FIRST

	var/list/all_tracks = list()

/subsystem/track/Initialize()
	for(var/k in subtypesof(/track/))
		var/track/T = new k
		all_tracks[T.type] = T

	log_subsystem(name,"Initialized [length(all_tracks)] music tracks.")
	return ..()