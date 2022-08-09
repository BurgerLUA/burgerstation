SUBSYSTEM_DEF(smoothing)
	name = "Smoothing Subsystem"
	desc = "Smooths turfs and objects."
	priority = SS_ORDER_LAST
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
	. = ..()

/subsystem/smoothing/on_life()
	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return FALSE
	process_edges()
	return TRUE

/subsystem/smoothing/proc/process_edges()
	for(var/k in queued_smoothing)
		queued_smoothing -= k
		var/atom/A = k
		A.update_sprite()
		CHECK_TICK_SAFE(cpu_usage_max,FPS_SERVER)

/subsystem/smoothing/proc/queue_update_edges(var/turf/T,var/include_self=TRUE)

	var/list/valid_directions = DIRECTIONS_ALL
	if(include_self)
		valid_directions |= 0x0

	for(var/direction in valid_directions)
		var/turf/T2 = direction == 0x0 ? T : get_step(T,direction)
		if(!T2)
			continue
		if(T2.corner_icons)
			SSsmoothing.queued_smoothing |= T2
		for(var/obj/structure/O in T2.contents)
			if(O.corner_icons)
				SSsmoothing.queued_smoothing |= O
		CHECK_TICK_SAFE(cpu_usage_max,FPS_SERVER)


	return TRUE