SUBSYSTEM_DEF(obj)
	name = "Objs Subsystem"
	desc = "Initialize objs after they are made. Also handles queued object smoothing."
	priority = SS_ORDER_OBJS
	tick_rate = DECISECONDS_TO_TICKS(1)
	var/list/queued_smooth = list()

/subsystem/obj/Initialize()

	set background = 1

	var/list/initialize_early = list()
	var/list/initialize_normal = list()
	var/list/initialize_late = list()

	for(var/obj/O in world)
		if(O.initialize_type == INITIALIZE_EARLY)
			initialize_early += O
		else if(O.initialize_type == INITIALIZE_LATE)
			initialize_late += O
		else if(O.initialize_type == INITIALIZE_NORMAL)
			initialize_normal += O

	for(var/obj/O in initialize_early)
		INITIALIZE(O)
		SPAWN(O)

	log_subsystem(name,"Early: Initialized and spawned [length(initialize_early)] objects in world.")

	for(var/obj/O in initialize_normal)
		INITIALIZE(O)
		SPAWN(O)

	log_subsystem(name,"Normal: Initialized and spawned [length(initialize_normal)] objects in world.")

	for(var/obj/O in initialize_late)
		INITIALIZE(O)
		SPAWN(O)

	log_subsystem(name,"Late: Initialized and spawned [length(initialize_late)] objects in world.")

	log_subsystem(name,"Total: Initialized and spawned [length(initialize_early) + length(initialize_normal) + length(initialize_late)] total objects in world.")

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
