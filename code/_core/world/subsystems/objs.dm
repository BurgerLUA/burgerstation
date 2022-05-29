SUBSYSTEM_DEF(obj)
	name = "Objs Subsystem"
	desc = "Initialize objs after they are made. Also handles queued object smoothing."
	priority = SS_ORDER_OBJS

	var/list/initialize_early = list()
	var/list/initialize_normal = list()
	var/list/initialize_late = list()
	var/list/initialize_none = list()

	var/list/icon_cache = list()
	var/saved_icons = 0

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
