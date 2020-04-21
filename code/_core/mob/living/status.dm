/mob/living/proc/add_status(var/status_type,var/duration)
	if(!status_effects[status_type] || duration == -1)
		status_effects[status_type] = duration
	else
		status_effects[status_type] += duration
	return TRUE

/mob/living/proc/remove_status(var/status_type)
	status_effects -= status_type

/mob/living/proc/handle_status_effects(var/amount_to_remove = 1)

	for(var/status in status_effects)
		if(status_effects[status] == -1)
			continue
		if(status_effects[status] <= 0)
			remove_status(status)
			continue
		status_effects[status]--

	handle_horizontal()

	return TRUE


/mob/living/proc/has_status_effect(var/status_id)
	return status_effects[status_type] ? TRUE : FALSE

/mob/living/proc/get_status_effect_duration(var/status_id)
	return status_effects[status_type] ? status_effects[status_type]["duration"] : 0

/mob/living/proc/get_status_effect_magnitude(var/status_id)
	return status_effects[status_type] ? status_effects[status_type]["magnitude"] : 0

/mob/living/proc/add_paralyze(var/duration,var/force = FALSE)
	add_status(FLAG_STATUS_PARALYZE,duration,force)

/mob/living/proc/add_stun(var/duration,var/force = FALSE)
	add_status(FLAG_STATUS_STUN,duration,force)

/mob/living/proc/add_stagger(var/duration,var/force = FALSE)
	add_status(FLAG_STATUS_STAGGER,duration,force)

/mob/living/proc/add_adrenaline(var/duration,var/force = FALSE)
	add_status(FLAG_STATUS_ADRENALINE,duration,force)

/mob/living/proc/add_crit(var/duration,var/force = FALSE)
	add_status(FLAG_STATUS_CRIT,duration,force)

/mob/living/proc/add_rest(var/duration,var/force = FALSE)
	add_status(FLAG_STATUS_REST,duration,force)

/mob/living/proc/add_sleep(var/duration,var/force = FALSE)
	add_status(FLAG_STATUS_SLEEP,duration,force)