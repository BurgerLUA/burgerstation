var/global/list/all_tracks = list()

SUBSYSTEM_DEF(tracks)
	name = "Track Subsystem"
	desc = "Stores all the known musical tracks in a list."
	priority = SS_ORDER_FIRST

/subsystem/tracks/Initialize()
	for(var/k in subtypesof(/track/))
		var/track/T = new k
		all_tracks[T.type] = T

	log_subsystem(name,"Initialized [length(all_tracks)] music tracks.")
	return ..()