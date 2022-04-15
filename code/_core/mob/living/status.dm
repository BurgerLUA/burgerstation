/mob/living/proc/add_status_effect(var/status_type,var/magnitude=100,var/duration=null,var/atom/source,var/force=FALSE,var/stealthy=FALSE,var/bypass_limits=FALSE)

	if(!isnum(duration))
		duration = magnitude

	PROCESS_LIVING(src)

	//Check immunities first.
	if(!force && length(status_immune) && status_immune[status_type])
		if(isnum(status_immune[status_type]))
			if(ENABLE_DAMAGE_NUMBERS && !stealthy)
				var/turf/T = get_turf(src)
				if(T) new/obj/effect/temp/status_effect(T,duration,"IMMUNE!")
			return FALSE
		else
			status_type = status_immune[status_type]
			if(magnitude != -1)
				magnitude = magnitude*0.5
			if(duration != -1)
				duration = duration*0.5

	var/status_effect/S = SSstatus.all_status_effects[status_type]
	if(!S)
		CRASH_SAFE("Invalid status effect added! ([status_type])")
		return FALSE
	. = FALSE

	if(!S.can_add_status_effect(source,src))
		return FALSE

	if(!force)
		if(magnitude != -1)
			magnitude = S.modify_magnitude(source,src,magnitude,force)
		if(duration != -1)
			duration = S.modify_duration(source,src,duration)

	if(!status_effects[status_type])
		status_effects[status_type] = list()
		. = TRUE

	if(!status_effects[status_type]["duration"] || force || !status_effects[status_type]["magnitude"])
		status_effects[status_type]["duration"] = duration
	else //Duration exists.
		if(status_effects[status_type]["duration"] == -1) //Can't alter a permanent status effect.
			return FALSE
		var/mag_mod = magnitude/status_effects[status_type]["magnitude"]
		if(mag_mod >= 1) //New magnitude is stronger or equal to old
			status_effects[status_type]["duration"] = duration + (status_effects[status_type]["duration"]/mag_mod)
		else //New magnitude is weaker than old
			status_effects[status_type]["duration"] += mag_mod*duration

	if(!status_effects[status_type]["magnitude"] || force)
		status_effects[status_type]["magnitude"] = magnitude
	else
		status_effects[status_type]["magnitude"] = max(status_effects[status_type]["magnitude"],magnitude)

	if(!bypass_limits)
		if(S.minimum != -1 && status_effects[status_type]["duration"] != -1)
			status_effects[status_type]["duration"] = max(status_effects[status_type]["duration"],S.minimum)

		if(S.maximum != -1 && status_effects[status_type]["duration"] != -1)
			status_effects[status_type]["duration"] = min(status_effects[status_type]["duration"],S.maximum)

	if(.)
		S.on_effect_added(src,source,magnitude,duration,stealthy)
		handle_horizontal()

/mob/living/proc/remove_status_effect(var/status_type,var/check_horizontal=TRUE)
	if(!has_status_effect(status_type))
		return FALSE
	var/status_effect/S = SSstatus.all_status_effects[status_type]
	if(!S)
		CRASH_SAFE("Invalid status effect removed! ([status_type])")
		return FALSE
	S.on_effect_removed(src,status_type,status_effects[status_type]["magnitude"],status_effects[status_type]["duration"])
	status_effects -= status_type
	if(check_horizontal)
		handle_horizontal()

/mob/living/proc/remove_all_status_effects()
	for(var/status in status_effects)
		remove_status_effect(status,FALSE)
	handle_horizontal()

/mob/living/proc/handle_status_effects(var/amount_to_remove = 1)

	for(var/status in status_effects)
		var/status_effect/S = SSstatus.all_status_effects[status]
		S.on_effect_life(src,status_effects[status]["magnitude"],status_effects[status]["duration"])
		if(status_effects[status]["duration"] == -1)
			continue
		if(status_effects[status]["duration"] == 0)
			remove_status_effect(status)
			continue
		if(status_effects[status]["duration"] < -1)
			status_effects[status]["duration"] = min(-1,status_effects[status]["duration"] + amount_to_remove)
			continue
		status_effects[status]["duration"] = max(0,status_effects[status]["duration"] - amount_to_remove)

	return TRUE

/mob/living/proc/has_status_effect(var/status_type)
	if(src.status_effects[status_type])
		return TRUE
	return FALSE

/mob/living/proc/has_status_effects(...)
	for(var/status_type in args)
		if(src.status_effects[status_type])
			return TRUE
	return FALSE

/mob/living/proc/get_status_effect_duration(var/status_type)
	return status_effects[status_type] ? status_effects[status_type]["duration"] : 0

/mob/living/proc/get_status_effect_magnitude(var/status_type)
	return status_effects[status_type] ? status_effects[status_type]["magnitude"] : 0