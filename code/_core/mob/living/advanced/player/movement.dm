/mob/living/advanced/player/Cross(var/atom/crosser)

	if(is_player(crosser) && intent == INTENT_HARM && !(area && area.safe))
		return FALSE

	return ..()