/mob/living/proc/add_status_effect(var/status_type,var/magnitude,var/duration,var/atom/source,var/force=FALSE,var/stealthy=FALSE)

	var/status_effect/S = SSstatus.all_status_effects[status_type]
	if(!S)
		CRASH("Invalid status effect added! ([status_type])")
		return FALSE

	. = FALSE

	if(!status_effects[status_type])
		status_effects[status_type] = list()
		. = TRUE

	if(!status_effects[status_type]["duration"] || magnitude >= status_effects[status_type]["magnitude"] || force)
		status_effects[status_type]["duration"] = duration
	else
		status_effects[status_type]["duration"] += duration

	if(!status_effects[status_type]["magnitude"] || force)
		status_effects[status_type]["magnitude"] = magnitude
	else
		status_effects[status_type]["magnitude"] = max(status_effects[status_type]["magnitude"],magnitude)

	if(.)
		S.on_effect_added(src,source,status_type,magnitude,duration,stealthy)
		handle_horizontal()


	return .

/mob/living/proc/remove_status_effect(var/status_type,var/fuck_you=FALSE)
	if(!has_status_effect(status_type))
		return FALSE
	var/status_effect/S = SSstatus.all_status_effects[status_type]
	if(!S)
		CRASH("Invalid status effect removed! ([status_type])")
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
		if(status_effects[status]["duration"] == -1)
			continue
		if(status_effects[status]["duration"] == 0)
			remove_status_effect(status)
			continue
		if(status_effects[status]["duration"] < -1)
			status_effects[status]["duration"]++
			continue
		status_effects[status]["duration"]--

	return TRUE


/mob/living/proc/has_status_effect(var/status_type,var/and=FALSE) //Accepts lists! Defaults to OR. Set to true if you want AND.

	if(islist(status_type))
		for(var/v in status_type)
			if(has_status_effect(v))
				return TRUE
			else if(and)
				return FALSE
	else if(src.status_effects[status_type])
		return TRUE

	return FALSE

/mob/living/proc/get_status_effect_duration(var/status_type)
	return status_effects[status_type] ? status_effects[status_type]["duration"] : 0

/mob/living/proc/get_status_effect_magnitude(var/status_type)
	return status_effects[status_type] ? status_effects[status_type]["magnitude"] : 0