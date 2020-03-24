/mob/living/advanced/player/add_stun(var/value,var/max_value = 40)
	drop_held_objects(src.loc)
	return ..()

/mob/living/advanced/player/can_be_attacked(var/atom/attacker)

	if(is_player(attacker) && attacker != src && !FRIENDLY_FIRE)
		return FALSE

	return ..()
