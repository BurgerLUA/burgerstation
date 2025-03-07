/mob/living/advanced/npc/
	ai = /ai/advanced/
	var/dialogue_id

/mob/living/advanced/npc/proc/can_talk_to(var/mob/activator)

	if(!dialogue_id)
		return FALSE

	if(!is_player(activator) || !activator.client)
		return FALSE

	var/mob/living/L = activator

	if(L.intent != INTENT_HELP)
		return FALSE

	if(L.loyalty_tag != src.loyalty_tag)
		return FALSE

	if(L.dead || src.dead)
		return FALSE

	if(get_dist(activator,src) > 2)
		return FALSE

	return TRUE


/mob/living/advanced/npc/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(can_talk_to(activator))
		///Interact check isn't here because INTERACT_CHECK covers most of it and can_talk_to handles distance checks.
		var/mob/living/advanced/player/P = activator
		P.dialogue_target = src
		P.dialogue_target_id = dialogue_id
		open_menu(P,/menu/dialogue/)
		return TRUE

	return ..()