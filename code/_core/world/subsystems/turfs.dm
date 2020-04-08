SUBSYSTEM_DEF(turfs)
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS
	tick_rate = SECONDS_TO_TICKS(1)


	var/list/queued_edges = list()

/subsystem/turfs/Initialize()

	set background = 1

	if(!ENABLE_TURFGEN)
		return

	var/turf_count = 0

	for(var/turf/simulated/S in world)
		INITIALIZE(S)
		turf_count++

	log_subsystem(name,"Initialized [turf_count] turfs.")
	log_subsystem(name,"Stored [length(turf_icon_cache)] icons and saved [saved_icons] redundent icons.")

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