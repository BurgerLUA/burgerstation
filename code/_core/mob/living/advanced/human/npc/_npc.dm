/mob/living/advanced/npc/
	name = "greytide"
	enable_AI = TRUE
	ai = /ai/

	var/dialogue_id

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC


/mob/living/advanced/npc/defer_click_on_object(location,control,params)

	if(dialogue_id)
		return src

	return ..()

/mob/living/advanced/npc/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

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