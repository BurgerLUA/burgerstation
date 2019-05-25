/mob/living/advanced/player/Cross(var/atom/crosser)

	if(area && area.safe && is_player(crosser)) //No collisions in safe areas.
		return TRUE

	return intent == INTENT_HARM