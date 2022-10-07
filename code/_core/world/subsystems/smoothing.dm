SUBSYSTEM_DEF(smoothing)
	name = "Smoothing Subsystem"
	desc = "Smooths turfs and objects."
	priority = SS_ORDER_SMOOTHING
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/queued_smoothing = list()

	tick_usage_max = 75

	var/list/seeds = list() //id = value

/subsystem/smoothing/Initialize()
	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return FALSE
	log_subsystem(src.name,"Processing [length(queued_smoothing)] edges...")
	on_life()
	return TRUE

/subsystem/smoothing/on_life()

	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return FALSE

	for(var/k in queued_smoothing)
		src.queued_smoothing -= k
		var/atom/A = k
		A.queued_smoothing = FALSE
		A.update_sprite()
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	return TRUE


/subsystem/smoothing/proc/queue_update_edges(var/turf/T,var/include_self=TRUE)

	var/list/valid_directions = DIRECTIONS_ALL
	if(include_self)
		valid_directions |= 0x0

	for(var/direction in valid_directions)
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
		var/turf/T2 = direction == 0x0 ? T : get_step(T,direction)
		if(!T2)
			continue
		if(T2.corner_icons)
			queue_smoothing(T2)
		for(var/obj/structure/O in T2.contents)
			CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
			if(O.corner_icons)
				queue_smoothing(O)


	return TRUE