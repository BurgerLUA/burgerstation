/datum/
	var/qdel_attempts = 0
	var/qdel_warning = 0
	var/qdel_warning_time = FALSE
	var/qdeleting = FALSE
	var/initialized = FALSE
	var/list/hooks


/datum/proc/Initialize()
	initialized = TRUE
	return TRUE


/datum/proc/is_safe_to_delete()
	return TRUE

/datum/Destroy()

	if(hooks)
		hooks.Cut()
		hooks = null

	return ..()