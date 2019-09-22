/subsystem/living/
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = DECISECONDS_TO_TICKS(LIFE_TICK)
	priority = SS_ORDER_IMPORTANT

	var/advanced_ticks = 0

/subsystem/living/Initialize()

	for(var/mob/living/L in all_living)
		L.Initialize()

	LOG_SERVER("Initialized [length(all_living)] living beings.")

/subsystem/living/on_life()

	for(var/mob/living/L in all_living)
		L.on_life()
		if(!L.ckey && L.enable_AI)
			L.on_life()
		if(advanced_ticks >= floor(LIFE_TICK_SLOW/LIFE_TICK))
			L.on_life_slow()
			advanced_ticks = 0
		advanced_ticks++

	return TRUE