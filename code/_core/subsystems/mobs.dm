/datum/subsystem/mobs/
	name = "Living Mob Subsystem"
	desc = "Controls how living mobs behave. Includes AI."
	tick_rate = 0
	priority = SS_ORDER_MOBS

/datum/subsystem/mobs/on_life()
	for(var/mob/living/L in all_living)
		if(L.ckey || !L.enable_AI)
			continue
		L.on_life_AI()

	return TRUE