/mob/living/advanced/player/can_collide_with(var/atom/A)

	if(is_player(A))
		return (intent == INTENT_HARM) && !(area && area.safe)

	return ..()