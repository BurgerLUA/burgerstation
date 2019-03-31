/mob/living/Move()

	if(stun_time == -1)
		return FALSE

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	return ..()


/mob/living/get_movement_delay()
	. = ..()

	if(status & FLAG_STATUS_STUN)
		. *= 4

	. = max(1, . - (. * get_skill_power(SKILL_ATHLETICS,1,100) * 0.5))

	return .