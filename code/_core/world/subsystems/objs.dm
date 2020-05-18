SUBSYSTEM_DEF(obj)
	name = "Objs Subsystem"
	desc = "Initialize objs after they are made. Also handles queued object smoothing."
	priority = SS_ORDER_OBJS
	tick_rate = DECISECONDS_TO_TICKS(1)
	var/list/queued_smooth = list()

/subsystem/obj/Initialize()

	set background = 1

	var/initialize_early = 0
	var/initialize_normal = 0
	var/initialize_late = 0

	for(var/obj/O in world)
		if(O.initialize_type != INITIALIZE_EARLY)
			continue
		INITIALIZE(O)
		SPAWN(O)
		initialize_early++

	log_subsystem(name,"Early: Initialized and spawned [initialize_early] objects in world.")

	for(var/obj/O in world)
		if(O.initialize_type != INITIALIZE_NORMAL)
			continue
		INITIALIZE(O)
		SPAWN(O)
		initialize_normal++

	log_subsystem(name,"Normal: Initialized and spawned [initialize_normal] objects in world.")

	for(var/obj/O in world)
		if(O.initialize_type != INITIALIZE_LATE)
			continue
		INITIALIZE(O)
		SPAWN(O)
		initialize_late++

	log_subsystem(name,"Late: Initialized and spawned [initialize_late] objects in world.")

	log_subsystem(name,"Total: Initialized and spawned [initialize_early + initialize_normal + initialize_late] total objects in world.")

/subsystem/obj/on_life()

	for(var/obj/structure/smooth/S in queued_smooth)
		S.update_sprite()
		queued_smooth -= S

	return TRUE

/proc/queue_update_smooth_edges(var/obj/structure/smooth/S)

	SSobj.queued_smooth |= S

	for(var/direction in DIRECTIONS_ALL)
		var/turf/T = get_step(S,direction)
		for(var/obj/structure/smooth/S2 in T.contents)
			SSobj.queued_smooth |= S2

	return TRUE
