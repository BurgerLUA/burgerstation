/mob/living/simple/npc/
	enable_AI = TRUE

/mob/living/simple/npc/on_life_AI()

	if(!initialized)
		Initialize()
		return TRUE //Wait until next tick.

	if(ai)
		ai.on_life()



	handle_movement(TRUE)

	return TRUE