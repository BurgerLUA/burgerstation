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

	loot_drop_in_corpse = TRUE

/mob/living/advanced/npc/defer_click_on_object()

	if(dialogue_id)
		return src

	return ..()

/mob/living/advanced/npc/can_be_attacked(var/atom/attacker)

	if(dialogue_id)
		return FALSE

	return ..()

/mob/living/advanced/npc/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(dialogue_id && is_player(caller))
		var/mob/living/advanced/player/P = caller
		P.dialogue_target = src
		P.dialogue_target_id = dialogue_id
		open_menu(P,"dialogue")
		return TRUE

	return ..()

/mob/living/advanced/npc/get_xp_multiplier()
	return 0


/mob/living/advanced/check_death()

	if(!health)
		return FALSE

	return health.health_current <= 0