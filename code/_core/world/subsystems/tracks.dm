var/global/list/all_tracks = list()

/subsystem/tracks/
	name = "Track Subsystem"
	desc = "Stores all the known musical tracks in a list."
	priority = SS_ORDER_NORMAL

/subsystem/tracks/Initialize()
	for(var/k in subtypesof(/track/))
		var/track/T = new k
		all_tracks[T.id] = T

	LOG_SERVER("Initialized [length(all_tracks)] music tracks.")