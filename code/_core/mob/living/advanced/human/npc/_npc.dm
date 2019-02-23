/mob/living/advanced/human/npc
	name = "greytide"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/

/mob/living/get_xp_multiplier()
	return 1

/mob/living/advanced/human/npc/can_be_grabbed()
	return status & FLAG_STATUS_DEAD

/mob/living/advanced/human/npc/can_not_enter(var/atom/A,var/move_direction)
	return src

/mob/living/advanced/human/npc/do_bump(var/atom/bumper, var/bump_direction = 0, var/movement_override = 0)
	return FALSE

/mob/living/advanced/human/npc/on_life_AI()

	if(!initialized)
		Initialize()
		return TRUE //Wait until next tick.

	if(ai)
		ai.on_life()

	handle_movement(DECISECONDS_TO_TICKS(1))

	return TRUE