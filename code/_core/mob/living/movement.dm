/mob/living/can_not_enter(var/atom/A,var/move_direction)

	if(is_living(A))
		var/mob/living/L = A
		if(L.status & FLAG_STATUS_STUN)
			return FALSE

	if(status & FLAG_STATUS_STUN)
		return FALSE

	if(area && area.safe)
		return FALSE

	return src

/mob/living/get_movement_delay()
	. = ..()

	if(status & FLAG_STATUS_STUN)
		. *= 4

	. = max(1, . - (. * get_skill_power(SKILL_ATHLETICS,1,100) * 0.5))

	return .