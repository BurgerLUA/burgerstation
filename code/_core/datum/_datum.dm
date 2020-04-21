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