SUBSYSTEM_DEF(turf)
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/wet_turfs = list()

	cpu_usage_max = 50
	tick_usage_max = 50

	var/list/seeds = list()

	var/list/icon_cache = list()
	var/saved_icons = 0

/subsystem/turf/unclog(var/mob/caller)

	for(var/k in wet_turfs)
		wet_turfs -= k

	broadcast_to_clients(span("danger","Removed all wet turfs and queued edges."))

	return ..()

/subsystem/turf/Initialize()

	set background = 1 //Needed because it thinks it's doing an infinite loop.

	log_subsystem(src.name,"Generating seeds...")
	for(var/i=1,i<=20,i++) //Generate 10 seeds.
		seeds += rand(1,99999)

	log_subsystem(src.name,"Setting worldspawn...")
	for(var/turf/simulated/T in world)
		T.world_spawn = TRUE
		sleep(-1)

	//First generation pass.
	log_subsystem(src.name,"Pregenerating turfs...")
	for(var/turf/unsimulated/generation/G in world)
		G.pre_generate()
		sleep(-1)

	//Second generation pass.
	log_subsystem(src.name,"Generating turfs...")
	for(var/turf/unsimulated/generation/G in world)
		G.generate()
		sleep(-1)

	if(!CONFIG("ENABLE_INSTALOAD",FALSE))

		var/list/generations_first = list()
		var/list/generations_second = list()
		var/list/generations_third = list()

		log_subsystem(src.name,"Sorting generation markers...")
		for(var/k in all_generation_markers)
			var/obj/marker/generation/G = k
			if(G.bypass_disallow_generation || priority >= 3)
				generations_third += G
			else if(priority >= 2)
				generations_second += G
			else
				generations_first += G

		log_subsystem(src.name,"Generating first markers...")
		for(var/k in generations_first)
			var/obj/marker/generation/G = k
			G.generate_marker()
			sleep(-1)

		log_subsystem(src.name,"Generating second markers...")
		for(var/k in generations_second)
			var/obj/marker/generation/G = k
			G.generate_marker()
			sleep(-1)

		log_subsystem(src.name,"Generating third markers...")
		for(var/k in generations_third)
			var/obj/marker/generation/G = k
			G.generate_marker()
			sleep(-1)

	log_subsystem(src.name,"Initializing turfs...")
	for(var/turf/simulated/S in world)
		INITIALIZE(S)
		sleep(-1)

	var/list/type_to_time = list()

	log_subsystem(src.name,"Finalizing turfs...")
	for(var/turf/simulated/S in world)
		var/benchmark = true_time()
		FINALIZE(S)
		type_to_time[S.type] += true_time() - benchmark
		sleep(-1)

	sortInsert(type_to_time, /proc/cmp_numeric_dsc, associative=TRUE)

	type_to_time.Cut(5)
	log_debug("5 Most Expensive Turfs:")
	for(var/k in type_to_time)
		var/v = type_to_time[k]
		log_debug("[k]: [DECISECONDS_TO_SECONDS(v)] seconds")

	. = ..()

/subsystem/turf/on_life()

	for(var/k in wet_turfs)
		var/turf/simulated/T = k
		T.wet_level = max(0, T.wet_level - T.wet_level*T.drying_mul - T.drying_add)
		if(T.wet_level <= 0)
			wet_turfs -= T
			T.overlays.Cut()
			T.update_overlays()
		CHECK_TICK_SAFE(75,FPS_SERVER*3)

	return TRUE
