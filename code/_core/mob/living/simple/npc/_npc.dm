/mob/living/simple/npc/
	enable_AI = TRUE
	var/loot_drop


/mob/living/simple/npc/Initialize()
	..()

/mob/living/simple/npc/on_life_AI()

	if(!initialized)
		Initialize()
		return TRUE //Wait until next tick.

	if(ai)
		ai.on_life()

	handle_movement(DECISECONDS_TO_TICKS(1))

	return TRUE


/mob/living/simple/npc/death()
	if(..())
		var/turf/T = get_turf(src)
		if(T && loot_drop)
			var/loot/L = all_loot[loot_drop]
			L.spawn_loot_turf(T)
		return TRUE

	return FALSE


