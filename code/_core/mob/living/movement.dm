/mob/living/Move()

	if(stun_time == -1)
		return FALSE

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(is_sneaking)
		on_sneak()

	return ..()


/mob/living/get_movement_delay()
	. = ..()

	if(status & FLAG_STATUS_STUN)
		. *= 4

	if(is_sneaking)
		. *= 2

	. = max(1, . - (. * get_skill_power(SKILL_ATHLETICS,1,100) * 0.5))

	return .


/mob/living/proc/toggle_sneak(var/on = TRUE)
	if(on)
		stealth_mod = get_skill_power(SKILL_STEALTH,1,100)
		is_sneaking = TRUE
		return TRUE
	else
		is_sneaking = FALSE
		return FALSE

/mob/living/proc/on_sneak()
	return TRUE

/mob/living/proc/update_alpha(var/desired_alpha)
	if(alpha != desired_alpha)
		world.log << "NEW ALPHA: [desired_alpha]"
		animate(src, alpha = desired_alpha, color = rgb(desired_alpha,desired_alpha,desired_alpha), time = SECONDS_TO_DECISECONDS(1))
		return TRUE

	return FALSE

