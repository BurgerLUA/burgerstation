/mob/living/simple/npc/
	enable_AI = TRUE

/mob/living/simple/npc/Initialize()
	..()

/mob/living/simple/npc/on_life_AI()

	if(ai)
		ai.on_life()
		handle_movement(DECISECONDS_TO_TICKS(LIFE_TICK))

	return TRUE

