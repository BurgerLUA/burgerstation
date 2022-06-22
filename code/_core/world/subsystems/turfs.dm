SUBSYSTEM_DEF(turf)
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/wet_turfs = list()

	cpu_usage_max = 50
	tick_usage_max = 50

	var/list/seeds = list() //id = value

	var/list/icon_cache = list()
	var/saved_icons = 0

	var/list/blood_turfs = list()



/subsystem/turf/unclog(var/mob/caller)

	for(var/k in wet_turfs)
		wet_turfs -= k

	broadcast_to_clients(span("danger","Removed all wet turfs and queued edges."))

	return ..()

/subsystem/turf/Initialize()

	set background = 1 //Needed because it thinks it's doing an infinite loop.

	for(var/i=1,i<=10,i++) //Generate 10 seeds.
		seeds += rand(1,99999)

	for(var/turf/simulated/T in world)
		T.world_spawn = TRUE

	//First generation pass.
	for(var/turf/unsimulated/generation/G in world)
		G.pre_generate()
		CHECK_TICK(cpu_usage_max,FPS_SERVER)

	//Second generation pass.
	for(var/turf/unsimulated/generation/G in world)
		G.generate()
		CHECK_TICK(cpu_usage_max,FPS_SERVER)

	if(ENABLE_GENERATION)

		var/list/generations_first = list()
		var/list/generations_second = list()
		var/list/generations_third = list()

		for(var/k in all_generation_markers)
			var/obj/marker/generation/G = k
			if(G.bypass_disallow_generation || priority >= 3)
				generations_third += G
			else if(priority >= 2)
				generations_second += G
			else
				generations_first += G
			CHECK_TICK(cpu_usage_max,FPS_SERVER)

		for(var/k in generations_first)
			var/obj/marker/generation/G = k
			G.generate_marker()
			CHECK_TICK(cpu_usage_max,FPS_SERVER)

		for(var/k in generations_second)
			var/obj/marker/generation/G = k
			G.generate_marker()
			CHECK_TICK(cpu_usage_max,FPS_SERVER)

		for(var/k in generations_third)
			var/obj/marker/generation/G = k
			G.generate_marker()
			CHECK_TICK(cpu_usage_max,FPS_SERVER)

	for(var/turf/simulated/S in world)
		INITIALIZE(S)
		CHECK_TICK(cpu_usage_max,FPS_SERVER)

	for(var/turf/simulated/S in world)
		FINALIZE(S)
		CHECK_TICK(cpu_usage_max,FPS_SERVER)

	. = ..()

/subsystem/turf/on_life()

	for(var/k in wet_turfs)
		var/turf/simulated/T = k
		T.wet_level = max(0, T.wet_level - T.wet_level*T.drying_mul - T.drying_add)
		if(T.wet_level <= 0)
			wet_turfs -= T
			T.overlays.Cut()
			T.update_overlays()
		CHECK_TICK(75,FPS_SERVER*3)

	return TRUE
