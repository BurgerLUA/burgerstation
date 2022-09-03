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
		if(!O.loc)
			initialize_none += O
			continue
		if(O.initialize_type == INITIALIZE_EARLY)
			initialize_early += O
		else if(O.initialize_type == INITIALIZE_NORMAL)
			initialize_normal += O
		else if(O.initialize_type == INITIALIZE_LATE)
			initialize_late += O
		else
			initialize_none += O

	for(var/k in initialize_early)
		var/obj/O = k
		INITIALIZE(O)
	for(var/k in initialize_early)
		var/obj/O = k
		GENERATE(O)
	for(var/k in initialize_early)
		var/obj/O = k
		FINALIZE(O)

	for(var/k in initialize_normal)
		var/obj/O = k
		INITIALIZE(O)
	for(var/k in initialize_normal)
		var/obj/O = k
		GENERATE(O)
	for(var/k in initialize_normal)
		var/obj/O = k
		FINALIZE(O)

	for(var/k in initialize_late)
		var/obj/O = k
		INITIALIZE(O)
	for(var/k in initialize_late)
		var/obj/O = k
		GENERATE(O)
	for(var/k in initialize_late)
		var/obj/O = k
		FINALIZE(O)

	initialize_early.Cut()
	initialize_normal.Cut()
	initialize_late.Cut()
	initialize_none.Cut()

	return ..()
