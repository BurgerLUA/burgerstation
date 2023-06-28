SUBSYSTEM_DEF(living)
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = LIFE_TICK_FAST
	priority = SS_ORDER_LIFE

	var/slow_ticks = 0
	var/normal_ticks = 0

	tick_usage_max = 80

	use_time_dialation = FALSE

	var/list/stored_addictions = list()
	var/list/mob/living/all_living = list()
	var/list/dna/all_dna = list()

	var/list/mob/living/processing_mobs = list()

	var/next_report = SECONDS_TO_DECISECONDS(300)

/subsystem/living/unclog(var/mob/caller)

	for(var/k in processing_mobs)
		var/mob/living/L = k
		processing_mobs -= k
		if(!L || L.qdeleting)
			continue
		if(is_player(L))
			UNPROCESS_LIVING(L)
		else
			qdel(L)

	. = ..()

/subsystem/living/Initialize()

	for(var/k in subtypesof(/dna/))
		var/dna/D = new k
		all_dna[k] = D

	for(var/k in all_living)
		var/mob/living/L = k
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)
		CHECK_TICK_HARD

	log_subsystem(name,"Initialized [length(all_living)] living beings.")

	for(var/k in subtypesof(/addiction/))
		var/addiction/A = new k
		stored_addictions[k] = A

	var/total_spawnpoints = 0
	for(var/k in src.all_living) //Setup spawnpoints for respawning mobs.
		var/mob/living/L = k
		if(!is_turf(L.loc))
			continue
		var/turf/T = L.loc
		var/area/A = T.loc


		var/chunk/CH = CHUNK(T)

		if(L.ai)
			CH.ai += L.ai

		if(A.safe_storage)
			continue

		if(!L.respawn)
			continue

		if(!is_simulated(T))
			log_error("Warning: [T] at ([T.x],[T.y],[T.z]) is not a simulated turf and had a mob spawnpoint on it.")
			continue

		var/obj/marker/mob_spawn/M = new(T,L)
		M.set_dir(L.random_spawn_dir ? pick(NORTH,EAST,SOUTH,WEST) : L.dir)
		CH.spawning_markers += M
		total_spawnpoints++

	log_subsystem(src.name,"Created [total_spawnpoints] mob spawnpoints.")

	next_report = world.time + initial(next_report)

	. = ..()

/subsystem/living/on_life()

	var/do_slow = slow_ticks >= (LIFE_TICK_SLOW / LIFE_TICK_FAST)
	var/do_normal = normal_ticks >= (LIFE_TICK / LIFE_TICK_FAST)

	for(var/k in processing_mobs)
		var/mob/living/L = k
		if(!L.finalized || L.qdeleting)
			continue
		L.on_life_fast()
		if(do_normal)
			L.on_life()
		if(do_slow)
			L.on_life_slow()
		CHECK_TICK(tick_usage_max,DECISECONDS_TO_TICKS(1))

	if(do_slow)
		slow_ticks = 0
	else
		slow_ticks += 1

	if(do_normal)
		normal_ticks = 0
	else
		normal_ticks += 1

	if(next_report <= world.time)
		var/processing_count = length(processing_mobs)
		var/living_count = length(all_living)
		log_subsystem(src.name,"Processing [processing_count] active mobs, with [living_count] living beings existing.")
		next_report = world.time + initial(next_report)

	return TRUE