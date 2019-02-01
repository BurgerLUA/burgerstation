/datum/subsystem/health/
	name = "Mob Health Subsystem"
	desc = "Controls how health affects mobs."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_HEALTH

/datum/subsystem/health/on_life()
	for(var/mob/living/M in all_mobs)
		M.on_life()

	return TRUE