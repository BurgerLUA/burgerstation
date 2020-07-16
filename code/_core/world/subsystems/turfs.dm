

SUBSYSTEM_DEF(turfs)
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/queued_edges = list()

	cpu_usage_max = 50
	tick_usage_max = 50

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

	return ..()

/subsystem/turfs/on_life()
	for(var/turf/T in queued_edges)
		CHECK_TICK(75,FPS_SERVER*3)
		T.update_sprite()
		queued_edges -= T
	return TRUE

/proc/queue_update_turf_edges(var/turf/T)

	SSturfs.queued_edges |= T

	for(var/direction in DIRECTIONS_ALL)
		var/turf/T2 = get_step(T,direction)
		SSturfs.queued_edges |= T2

	return TRUE