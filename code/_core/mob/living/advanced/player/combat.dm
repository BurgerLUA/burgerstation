/mob/living/advanced/player/can_be_attacked(var/atom/attacker,var/damagetype/damage_type)

	if(is_player(attacker) && attacker != src && !FRIENDLY_FIRE)
		return FALSE

	return ..()
