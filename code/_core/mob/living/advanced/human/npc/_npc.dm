/mob/living/advanced/npc/
	name = "greytide"
	enable_AI = TRUE
	ai = /ai/advanced/

	var/dialogue_id

	soul_size = SOUL_SIZE_COMMON

/mob/living/advanced/npc/proc/can_talk_to(var/mob/caller)

	if(!dialogue_id)
		return FALSE

	if(!is_player(caller))
		return FALSE

	var/mob/living/L = caller

	if(L.intent != INTENT_HELP)
		return FALSE

	if(L.loyalty_tag != src.loyalty_tag)
		return FALSE

	if(L.dead || src.dead)
		return FALSE

	if(get_dist(caller,src) >= 3)
		return FALSE

	return TRUE


/mob/living/advanced/npc/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(can_talk_to(caller))
		///Interact check isn't here because INTERACT_CHECK covers most of it and can_talk_to handles distance checks.
		var/mob/living/advanced/player/P = caller
		P.dialogue_target = src
		P.dialogue_target_id = dialogue_id
		open_menu(P,/menu/dialogue/)
		return TRUE

	return ..()