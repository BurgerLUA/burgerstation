/mob/living/advanced/human/npc
	name = "greytide"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/

	var/dialogue_id

/mob/living/advanced/human/npc/clicked_by_object(var/mob/caller,object,location,control,params)
	if(dialogue_id && is_player(caller))
		var/mob/living/advanced/player/P = caller
		P.dialogue_target_id = dialogue_id
		open_menu(P,"dialogue")
		return TRUE
	return ..()

/mob/living/advanced/human/npc/get_xp_multiplier()
	return 1

/mob/living/advanced/human/npc/can_be_grabbed()
	return status & FLAG_STATUS_DEAD

/mob/living/advanced/human/npc/Cross(var/atom/moveable/A)
	return FALSE

/mob/living/advanced/human/npc/on_life_AI()

	if(!initialized)
		Initialize()
		return TRUE //Wait until next tick.

	if(ai)
		ai.on_life()

	handle_movement(DECISECONDS_TO_TICKS(1))

	return TRUE