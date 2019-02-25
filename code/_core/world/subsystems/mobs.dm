/subsystem/mobs/
	name = "Living Mob Subsystem"
	desc = "Controls how living mobs behave. Includes AI."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_MOBS

/subsystem/mobs/on_life()

	for(var/mob/living/L in all_living)
		if(L.ckey || !L.enable_AI)
			continue

		L.on_life_AI()

	return TRUE


