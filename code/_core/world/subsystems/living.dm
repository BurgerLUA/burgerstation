var/global/list/all_living = list()

SUBSYSTEM_DEF(living)
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = DECISECONDS_TO_TICKS(LIFE_TICK)
	priority = SS_ORDER_LIFE

	var/advanced_ticks = 0

/subsystem/living/Initialize()

	for(var/mob/living/L in all_living)
		CHECK_TICK
		if(ENABLE_MOB)
			INITIALIZE(L)
		else
			qdel(L)

	log_subsystem(name,"Initialized [length(all_living)] living beings.")
	return ..()


/subsystem/living/on_life()

	var/do_slow = advanced_ticks >= LIFE_TICKS_PER_SLOW_LIFE_TICKS

	for(var/mob/living/L in all_living)
		L.on_life()
		if(do_slow)
			L.on_life_slow()

	if(do_slow)
		advanced_ticks = 0
	else
		advanced_ticks += 1

	return TRUE