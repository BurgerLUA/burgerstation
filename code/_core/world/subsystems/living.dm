var/global/list/all_living = list()

SUBSYSTEM_DEF(living)
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = LIFE_TICK
	priority = SS_ORDER_LIFE

	var/advanced_ticks = 0

	tick_usage_max = 80
	cpu_usage_max = 80

	use_time_dialation = FALSE

	var/list/stored_addictions = list()

/subsystem/living/Initialize()

	var/bad_initialize = 0


	for(var/k in all_living)
		var/mob/living/L = k
		if(!L.client && istype(L.loc,/turf/simulated/wall))
			bad_initialize++
			qdel(L)
			continue
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)

	log_subsystem(name,"Failed to initialize [bad_initialize] living beings as they spawned in walls.")
	log_subsystem(name,"Initialized [length(all_living)] living beings.")

	for(var/k in subtypesof(/addiction/))
		var/addiction/A = new k
		stored_addictions[k] = A

	return ..()

/subsystem/living/on_life()

	var/do_slow = advanced_ticks >= LIFE_TICKS_PER_SLOW_LIFE_TICKS

	for(var/k in all_living)
		var/mob/living/L = k
		CHECK_TICK(tick_usage_max,DECISECONDS_TO_TICKS(1))
		if(!L.finalized || L.qdeleting)
			continue
		L.on_life()
		if(do_slow)
			L.on_life_slow()

	if(do_slow)
		advanced_ticks = 0
	else
		advanced_ticks += 1

	return TRUE