/mob/living/advanced/npc/
	name = "greytide"
	enable_AI = TRUE
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/

	var/dialogue_id

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

/mob/living/advanced/npc/clicked_by_object(var/mob/caller,object,location,control,params)
	if(dialogue_id && is_player(caller))
		var/mob/living/advanced/player/P = caller
		P.dialogue_target_id = dialogue_id
		open_menu(P,"dialogue")
		return TRUE

	return ..()

/mob/living/advanced/npc/get_xp_multiplier()
	return 0

/mob/living/advanced/npc/can_be_grabbed()
	return status & FLAG_STATUS_DEAD