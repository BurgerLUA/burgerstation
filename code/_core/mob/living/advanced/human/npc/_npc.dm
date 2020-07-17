/mob/living/advanced/npc/
	name = "greytide"
	enable_AI = TRUE
	ai = /ai/

	var/dialogue_id

	/*
	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	*/

/*
/mob/living/advanced/npc/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(attacker && dialogue_id && is_player(attacker))
		return FALSE

	return ..()
*/

/mob/living/advanced/npc/proc/can_talk_to(var/mob/caller)

	if(!is_living(caller))
		return FALSE

	var/mob/living/L = caller

	if(L.loyalty_tag != src.loyalty_tag)
		return FALSE

	if(L.dead || src.dead)
		return FALSE

	if(get_dist(caller,src) >= 3)
		return FALSE

	return TRUE


/mob/living/advanced/npc/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(dialogue_id && is_player(caller) && can_talk_to(caller))
		var/mob/living/advanced/player/P = caller
		P.dialogue_target = src
		P.dialogue_target_id = dialogue_id
		open_menu(P,"dialogue")
		return TRUE

	return ..()