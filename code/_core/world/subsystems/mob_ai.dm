SUBSYSTEM_DEF(mob)
	name = "Mob Movement Subsystem"
	desc = "Controls how AI moves. Seperate from the AI system for reasons."
	tick_rate = MOB_TICK
	priority = SS_ORDER_MOBS

/subsystem/mob/on_life()

	for(var/mob/living/L in all_living)
		if(L.ckey || !L.enable_AI)
			continue

		L.on_life_AI()

	return TRUE


