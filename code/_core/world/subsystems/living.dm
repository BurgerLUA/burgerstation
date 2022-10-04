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

/subsystem/living/Initialize()

	for(var/k in subtypesof(/dna/))
		var/dna/D = new k
		all_dna[k] = D

	for(var/k in all_living)
		var/mob/living/L = k
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)

	log_subsystem(name,"Initialized [length(all_living)] living beings.")

	for(var/k in subtypesof(/addiction/))
		var/addiction/A = new k
		stored_addictions[k] = A

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
		CHECK_TICK_SAFE(tick_usage_max,DECISECONDS_TO_TICKS(1))

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
		log_subsystem(src.name,"Processing [processing_count] mobs, with [living_count] living beings active.")
		next_report = world.time + initial(next_report)

	return TRUE