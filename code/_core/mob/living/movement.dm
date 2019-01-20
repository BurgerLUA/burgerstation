/mob/living/can_move(var/turf/new_loc,var/movement_override = 0)

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	return ..()

/mob/living/do_bump(var/atom/bumper, var/bump_direction = 0, var/movement_override = 0)
	if(move_delay > 0)
		return FALSE
	return do_move(get_step(src,bump_direction),movement_override)

/mob/living/can_not_enter(var/atom/A,var/move_direction)

	if(is_living(A))
		var/mob/living/L = A
		if(L.status & FLAG_STATUS_STUN)
			return FALSE

	if(status & FLAG_STATUS_STUN)
		return FALSE

	return src

/mob/living/get_movement_delay()
	. = ..()

	if(status & FLAG_STATUS_STUN)
		. *= 4

	. = max(1, . - (. * get_skill_power(SKILL_ATHLETICS,1,100) * 0.5))

	return .
