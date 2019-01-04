/datum/subsystem/mobs/
	name = "Mob Subsystem"
	desc = "Controls how mobs behave. Includes AI."
	tick_rate = 1
	priority = 99
	priority = SS_ORDER_MOBS

/datum/subsystem/mobs/on_life()
	for(var/mob/M in all_mobs)
		if(M.ckey || !M.enable_AI)
			continue
		M.on_life_AI()

	return TRUE