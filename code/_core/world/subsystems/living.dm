var/global/list/all_living = list()

SUBSYSTEM_DEF(living)
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = DECISECONDS_TO_TICKS(LIFE_TICK)
	priority = SS_ORDER_LIFE

	var/advanced_ticks = 0

	tick_usage_max = 80
	cpu_usage_max = 80

	use_time_dialation = FALSE

/subsystem/living/Initialize()

	if(!ENABLE_MOB)
		return ..()

	for(var/k in all_living)
		var/mob/living/L = k
		if(istype(L.loc,/turf/simulated/wall))
			qdel(L)
			continue
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)

	log_subsystem(name,"Initialized [length(all_living)] living beings.")

	return ..()

/subsystem/living/on_life()

	var/do_slow = advanced_ticks >= LIFE_TICKS_PER_SLOW_LIFE_TICKS

	for(var/k in all_living)
		var/mob/living/L = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		L.on_life()
		if(do_slow)
			L.on_life_slow()

	if(do_slow)
		advanced_ticks = 0
	else
		advanced_ticks += 1

	return TRUE