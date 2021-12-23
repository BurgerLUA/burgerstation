SUBSYSTEM_DEF(smoothing)
	name = "Smoothing Subsystem"
	desc = "Smooths turfs and objects."
	priority = SS_ORDER_LAST
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/queued_smoothing = list()

	cpu_usage_max = 50
	tick_usage_max = 50

	var/list/seeds = list() //id = value

/subsystem/smoothing/Initialize()

	var/start_time = world.time

	log_subsystem(src.name,"Processing...")

	process_edges()

	log_subsystem(src.name,"Took [world.time - start_time] deciseconds.")

	. = ..()

/subsystem/smoothing/on_life()
	process_edges()
	return TRUE

/subsystem/smoothing/proc/process_edges()

	for(var/k in queued_smoothing)
		sleep(-1)
		queued_smoothing -= k
		var/atom/A = k
		A.update_sprite()

/proc/queue_update_edges(var/turf/T,var/include_self=TRUE)

	var/list/valid_directions = DIRECTIONS_ALL
	if(include_self)
		valid_directions |= 0x0

	for(var/direction in valid_directions)
		var/turf/T2 = direction == 0x0 ? T : get_step(T,direction)
		if(!T2)
			continue
		if(T2.corner_icons)
			SSsmoothing.queued_smoothing |= T2
		for(var/obj/O in T2.contents)
			if(O.corner_icons)
				SSsmoothing.queued_smoothing |= O


	return TRUE