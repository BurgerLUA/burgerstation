var/global/subsystem/turfs/SSturfs

/subsystem/turfs/
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS
	tick_rate = SECONDS_TO_TICKS(1)


	var/list/queued_edges = list()

/subsystem/turfs/New(var/desired_loc)
	SSturfs = src
	return ..()

/subsystem/turfs/Initialize()

	set background = 1

	if(!ENABLE_TURFGEN)
		return

	var/turf_count = 0

	for(var/turf/simulated/S in world)
		S.Initialize()
		turf_count++

	LOG_SERVER("Initialized [turf_count] turfs.")
	LOG_SERVER("Stored [length(turf_icon_cache)] icons and saved [saved_icons] redundent icons.")

/subsystem/turfs/on_life()

	for(var/turf/T in queued_edges)
		T.update_edges()
		queued_edges -= T

	return TRUE

/proc/queue_update_edges(var/turf/T)

	if(!(T in SSturfs.queued_edges))
		SSturfs.queued_edges += T
		return TRUE

	return FALSE