/mob/living/advanced/human/npc
	name = "greytide"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/

/mob/living/get_xp_multiplier()
	return 1

/mob/living/advanced/human/npc/on_life_AI()

	if(!initialized)
		Initialize()
		return TRUE //Wait until next tick.

	if(ai)
		ai.on_life()

	handle_movement(DECISECONDS_TO_TICKS(1))

	return TRUE