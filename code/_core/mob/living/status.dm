/mob/living/proc/add_status_effect(var/status_type,var/magnitude,var/duration,var/atom/source,var/force=FALSE,var/stealthy=FALSE)

	if(!force && length(status_immune) && status_immune[status_type])
		if(isnum(status_immune[status_type]))
			if(ENABLE_DAMAGE_NUMBERS && !stealthy) new/obj/effect/temp/damage_number(src.loc,duration,"IMMUNE!")
			return FALSE
		else
			status_type = status_immune[status_type]
			magnitude = magnitude*0.5
			duration = duration*0.5

	var/status_effect/S = SSstatus.all_status_effects[status_type]
	if(!S)
		CRASH_SAFE("Invalid status effect added! ([status_type])")
		return FALSE
	. = FALSE

	if(!S.can_add_status_effect(source,src))
		return FALSE

	if(!status_effects[status_type])
		status_effects[status_type] = list()
		. = TRUE

	if(!status_effects[status_type]["duration"] || force || !status_effects[status_type]["magnitude"])
		status_effects[status_type]["duration"] = duration
	else
		var/mag_mod = magnitude/status_effects[status_type]["magnitude"]
		if(mag_mod >= 1) //New magnitude is stronger or equal to old
			status_effects[status_type]["duration"] = duration + (status_effects[status_type]["duration"]/mag_mod)
		else //New magnitude is weaker than old
			status_effects[status_type]["duration"] += mag_mod*duration

	if(!status_effects[status_type]["magnitude"] || force)
		status_effects[status_type]["magnitude"] = magnitude
	else
		status_effects[status_type]["magnitude"] = max(status_effects[status_type]["magnitude"],magnitude)

	if(S.minimum != -1 && status_effects[status_type]["duration"] != -1)
		status_effects[status_type]["duration"] = max(status_effects[status_type]["duration"],S.minimum)

	if(S.maximum != -1 && status_effects[status_type]["duration"] != -1)
		status_effects[status_type]["duration"] = min(status_effects[status_type]["duration"],S.maximum)

	if(.)
		S.on_effect_added(src,source,magnitude,duration,stealthy)
		handle_horizontal()

	return .

/mob/living/proc/remove_status_effect(var/status_type,var/fuck_you=FALSE)
	if(!has_status_effect(status_type))
		return FALSE
	var/status_effect/S = SSstatus.all_status_effects[status_type]
	if(!S)
		CRASH_SAFE("Invalid status effect removed! ([status_type])")
		return FALSE
	S.on_effect_removed(src,status_type,status_effects[status_type]["magnitude"],status_effects[status_type]["duration"])
	status_effects -= status_type
	if(!fuck_you)
		handle_horizontal()

/mob/living/proc/remove_all_status_effects()
	for(var/status in status_effects)
		remove_status_effect(status,TRUE)
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
			status_effects[status]["duration"] = min(-1,status_effects[status]["duration"] + LIFE_TICK)
			continue
		status_effects[status]["duration"] = max(0,status_effects[status]["duration"] - LIFE_TICK)

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