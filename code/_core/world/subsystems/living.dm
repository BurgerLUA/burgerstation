/subsystem/living/
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

/subsystem/living/on_life()

	for(var/mob/living/L in all_mobs)
		L.on_life()
		if(!L.ckey && L.enable_AI)
			L.on_life_AI()

	return TRUE