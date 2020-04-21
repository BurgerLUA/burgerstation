/mob/living/advanced/player/can_be_attacked(var/atom/attacker)

	if(is_player(attacker) && attacker != src && !FRIENDLY_FIRE)
		return FALSE

	return ..()
