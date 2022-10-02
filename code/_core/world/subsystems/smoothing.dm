SUBSYSTEM_DEF(smoothing)
	name = "Smoothing Subsystem"
	desc = "Smooths turfs and objects."
	priority = SS_ORDER_SMOOTHING
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/queued_smoothing = list()

	cpu_usage_max = 25
	tick_usage_max = 25

	var/list/seeds = list() //id = value

/subsystem/smoothing/Initialize()
	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return FALSE
	log_subsystem(src.name,"Processing [length(queued_smoothing)] edges...")
	process_edges()
	return TRUE

/subsystem/smoothing/on_life()
	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return FALSE
	process_edges()
	return TRUE

/subsystem/smoothing/proc/process_edges()

	for(var/k in queued_smoothing)
		CHECK_TICK_HARD(95)
		src.queued_smoothing -= k
		var/atom/A = k
		A.queued_smoothing = FALSE
		A.update_sprite()

/subsystem/smoothing/proc/queue_update_edges(var/turf/T,var/include_self=TRUE)

	var/list/valid_directions = DIRECTIONS_ALL
	if(include_self)
		valid_directions |= 0x0

	for(var/direction in valid_directions)
		CHECK_TICK_HARD(95)
		var/turf/T2 = direction == 0x0 ? T : get_step(T,direction)
		if(!T2)
			continue
		if(T2.corner_icons)
			queue_smoothing(T2)
		for(var/obj/structure/O in T2.contents)
			CHECK_TICK_HARD(95)
			if(O.corner_icons)
				queue_smoothing(O)


	return TRUE