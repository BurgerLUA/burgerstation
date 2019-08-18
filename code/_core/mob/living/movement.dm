/mob/living/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	if(stun_time == -1)
		return FALSE

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(is_sneaking)
		on_sneak()

	return ..()

/mob/living/handle_movement(var/adjust_delay = 1)
	if(status & FLAG_STATUS_PARALYZE)
		return FALSE

	return ..()

/mob/living/get_movement_delay()
	. = ..()

	if(status & FLAG_STATUS_STUN)
		. *= 4

	if(is_sneaking)
		. *= (2 - stealth_mod*0.5)

	. *= 1 + (1 - get_skill_power(SKILL_ATHLETICS,1,100))*2

	return .


/mob/living/proc/toggle_sneak(var/on = TRUE)

	for(var/obj/hud/button/B in buttons)
		if(B.type == /obj/hud/button/sneak)
			var/obj/hud/button/sneak/S = B
			S.sneaking = on
			S.update_icon()

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
		animate(src, alpha = desired_alpha, color = rgb(desired_alpha,desired_alpha,desired_alpha), time = SECONDS_TO_DECISECONDS(1))
		return TRUE

	return FALSE

/*
/mob/living/Cross(var/atom/movable/M)

	var/area/A = get_area(src)

	if(!A.safe)
		var/turf/T = get_turf(M)

		var/count = 0
		for(var/mob/living/L in T.contents)
			count++

		if(count>1)
			return FALSE

	return ..()
*/