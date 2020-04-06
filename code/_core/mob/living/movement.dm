/mob/living/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)

	if(is_sneaking)
		on_sneak()

	. = ..()

	if(stored_alert_effect)
		stored_alert_effect.glide_size = src.glide_size
		stored_alert_effect.force_move(src.loc)

	if(.)
		table_count = 0

	if(ai)
		ai.on_move(.,NewLoc,Dir)

	if(stand)
		stand.on_move(.,NewLoc,Dir)

	return .


/mob/living/Bump(var/atom/obstacle,var/Dir=0)

	. = ..()

	if(ai)
		ai.Bump(obstacle)

	return .


/mob/living/handle_movement(var/adjust_delay = 1)

	if(dead)
		return FALSE

	if(status & FLAG_STATUS_PARALYZE)
		return FALSE

	if(status & FLAG_STATUS_STAGGER)
		return FALSE

	if(status & FLAG_STATUS_STUN)
		return FALSE

	if(status & FLAG_STATUS_CONFUSED)
		move_dir = pick(DIRECTIONS_ALL)

	if(move_dir)
		if(buckled_object && !buckled_object.unbuckle(src))
			return FALSE

		if(sleep_time == -1)
			sleep_time = 0
			check_status_effects()
			return FALSE

	return ..()

/mob/living/get_movement_delay()
	. = ..()

	if(status & FLAG_STATUS_FATIGUE)
		. *= 3

	if(status & FLAG_STATUS_REST)
		. *= 3

	if(is_sneaking)
		. *= (2 - stealth_mod*0.5)

	var/skill_power = get_attribute_power(ATTRIBUTE_AGILITY)

	. *= (2 - skill_power)

	return .


/mob/living/proc/toggle_sneak(var/on = TRUE)

	for(var/obj/hud/button/B in buttons)
		if(B.type == /obj/hud/button/sneak)
			var/obj/hud/button/sneak/S = B
			S.sneaking = on
			S.update_sprite()

	if(on)
		stealth_mod = get_skill_power(SKILL_SURVIVAL)
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