SUBSYSTEM_DEF(obj)
	name = "Objs Subsystem"
	desc = "Initialize objs after they are made. Also handles queued object smoothing."
	priority = SS_ORDER_OBJS
	tick_rate = DECISECONDS_TO_TICKS(1)
	var/list/queued_smooth = list()

	var/list/initialize_early = list()
	var/list/initialize_normal = list()
	var/list/initialize_late = list()
	var/list/initialize_none = list()

/subsystem/obj/Initialize()

	for(var/obj/O in world)
		if(O.initialize_type == INITIALIZE_EARLY)
			initialize_early += O
		else if(O.initialize_type == INITIALIZE_LATE)
			initialize_late += O
		else if(O.initialize_type == INITIALIZE_NORMAL)
			initialize_normal += O
		else
			initialize_none += O
			log_error("ERROR: [O.get_debug_name()] did not have a valid initialize_type ([O.initialize_type]) set!")

	for(var/k in initialize_early)
		var/obj/O = k
		INITIALIZE(O)
		GENERATE(O)
		FINALIZE(O)

	log_subsystem(name,"Early: Initialized and spawned [length(initialize_early)] objects in world.")

	for(var/k in initialize_normal)
		var/obj/O = k
		INITIALIZE(O)
		GENERATE(O)
		FINALIZE(O)

	log_subsystem(name,"Normal: Initialized and spawned [length(initialize_normal)] objects in world.")

	for(var/k in initialize_late)
		var/obj/O = k
		INITIALIZE(O)
		GENERATE(O)
		FINALIZE(O)

	log_subsystem(name,"Late: Initialized and spawned [length(initialize_late)] objects in world.")

	log_subsystem(name,"NULL: Could not initialize [length(initialize_none)] objects.")

	initialize_early.Cut()
	initialize_normal.Cut()
	initialize_late.Cut()
	initialize_none.Cut()

	return ..()

/subsystem/obj/on_life()

	for(var/k in queued_smooth)
		var/obj/structure/smooth/S = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)
		queued_smooth -= S
		S.update_sprite()
		//This doesn't need to be "processed" as the only thing that could go wrong is update sprite.

	return TRUE

/proc/queue_update_smooth_edges(var/obj/structure/smooth/S,var/include_self=TRUE)

	if(include_self)
		SSobj.queued_smooth |= S

	for(var/direction in DIRECTIONS_ALL)
		var/turf/T = get_step(S,direction)
		for(var/obj/structure/smooth/S2 in T.contents)
			SSobj.queued_smooth |= S2

	return TRUE
