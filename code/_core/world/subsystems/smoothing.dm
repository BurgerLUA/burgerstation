SUBSYSTEM_DEF(smoothing)
	name = "Smoothing Subsystem"
	desc = "Smooths turfs and objects."
	priority = SS_ORDER_SMOOTHING
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/queued_smoothing_objs = list()
	var/list/queued_smoothing_turfs = list()

	tick_usage_max = 75

	var/list/seeds = list() //id = value

/subsystem/smoothing/Initialize()
	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return FALSE
	log_subsystem(src.name,"Processing [length(queued_smoothing_turfs)] turf edges...")
	log_subsystem(src.name,"Processing [length(queued_smoothing_objs)] obj edges...")
	on_life()
	return TRUE

/subsystem/smoothing/on_life()

	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return FALSE

	for(var/k in queued_smoothing_objs)
		src.queued_smoothing_objs -= k
		var/obj/structure/S = k
		S.queued_smoothing = FALSE
		S.update_smooth_code()
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	for(var/k in queued_smoothing_turfs)
		src.queued_smoothing_turfs -= k
		var/turf/simulated/S = k
		S.queued_smoothing = FALSE
		S.update_smooth_code()
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	return TRUE


/subsystem/smoothing/proc/queue_update_edges(var/turf/T,var/include_self=TRUE)

	var/list/valid_directions = DIRECTIONS_ALL
	if(include_self)
		valid_directions |= 0x0

	for(var/direction in valid_directions)
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
		var/turf/simulated/T2 = direction == 0x0 ? T : get_step(T,direction)
		if(!T2 || !is_simulated(T2))
			continue
		if(T2.corner_icons)
			queue_smoothing_turf(T2)
		for(var/obj/structure/O in T2.contents)
			CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
			if(O.corner_icons)
				queue_smoothing_obj(O)


	return TRUE