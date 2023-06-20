SUBSYSTEM_DEF(obj)
	name = "Objs Subsystem"
	desc = "Initialize objs after they are made. Also handles queued object smoothing."
	priority = SS_ORDER_OBJS

	var/list/initialize_early = list()
	var/list/initialize_normal = list()
	var/list/initialize_late = list()
	var/list/initialize_superlate = list()

	var/list/icon_cache = list()
	var/saved_icons = 0

	tick_rate = 1

/subsystem/obj/unclog(var/mob/caller)

	for(var/k in initialize_superlate)
		var/obj/O = k
		initialize_superlate -= k
		if(!O || O.qdeleting)
			continue
		qdel(O)

	. = ..()

/subsystem/obj/Initialize()

	for(var/obj/O in world)
		if(!O || O.qdeleting)
			continue
		if(O.initialize_type == INITIALIZE_EARLY)
			initialize_early += O
		else if(O.initialize_type == INITIALIZE_NORMAL)
			initialize_normal += O
		else if(O.initialize_type == INITIALIZE_LATE)
			initialize_late += O
		else if(O.initialize_type == INITIALIZE_SUPERLATE)
			initialize_superlate += O
		CHECK_TICK_HARD

	for(var/k in initialize_early)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_early -= k
			continue
		INITIALIZE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_early)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_early -= k
			continue
		GENERATE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_early)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_early -= k
			continue
		FINALIZE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_normal)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_normal -= k
			continue
		INITIALIZE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_normal)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_normal -= k
			continue
		GENERATE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_normal)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_normal -= k
			continue
		FINALIZE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_late)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_late -= k
			continue
		INITIALIZE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_late)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_late -= k
			continue
		GENERATE(O)
		CHECK_TICK_HARD

	for(var/k in initialize_late)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_late -= k
			continue
		FINALIZE(O)
		CHECK_TICK_HARD

	initialize_early.Cut()
	initialize_normal.Cut()
	initialize_late.Cut()

	return ..()

/subsystem/obj/on_life()

	for(var/k in initialize_superlate)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_superlate -= k
			continue
		INITIALIZE(O)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
	for(var/k in initialize_superlate)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_superlate -= k
			continue
		GENERATE(O)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
	for(var/k in initialize_superlate)
		var/obj/O = k
		if(!O || O.qdeleting)
			initialize_superlate -= k
			continue
		FINALIZE(O)
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	initialize_superlate.Cut()

	tick_rate = -1

	return TRUE