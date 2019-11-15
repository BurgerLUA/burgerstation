var/global/list/all_living = list()

/subsystem/living/
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = DECISECONDS_TO_TICKS(LIFE_TICK)
	priority = SS_ORDER_IMPORTANT

	var/advanced_ticks = 0

/subsystem/living/Initialize()

	for(var/mob/living/L in all_living)
		if(ENABLE_MOB)
			L.Initialize()
		else
			qdel(L)

	LOG_SERVER("Initialized [length(all_living)] living beings.")

/subsystem/living/on_life()

	var/do_slow = advanced_ticks >= LIFE_TICKS_PER_SLOW_LIFE_TICKS

	for(var/mob/living/L in all_living)
		CHECK_TICK
		L.on_life()
		if(do_slow)
			L.on_life_slow()

	if(do_slow)
		advanced_ticks = 0
	else
		advanced_ticks += 1

	return TRUE