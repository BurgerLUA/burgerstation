/datum/
	var/qdel_warning = 0
	var/qdel_warning_time = FALSE
	var/qdeleting = FALSE
	var/initialized = FALSE
	var/generated = FALSE
	var/finalized = FALSE
	var/queue_delete_immune = FALSE
	var/list/hooks

/datum/proc/get_examine_list(var/mob/examiner)
	return list(div("examine_title","[src]"),div("examine_description","[src.type]"))

/datum/proc/get_examine_details_list(var/mob/examiner)
	return list()

/datum/proc/Initialize()
	if(initialized)
		CRASH_SAFE("WARNING: [src.get_debug_name()] was initialized twice!")
		return TRUE
	return TRUE

/datum/proc/PostInitialize()
	return TRUE

/datum/proc/Generate() //Generate the atom, giving it stuff if needed.
	return TRUE

/datum/proc/Finalize() //We're good to go.
	return TRUE

/datum/proc/is_safe_to_delete(var/check_loc = FALSE)
	return TRUE

/datum/proc/delete()
	qdel(src)
	return TRUE


/datum/Destroy()

	HOOK_CALL("Destroy")

	if(hooks)
		hooks.Cut()
		hooks = null

	return ..()


/datum/proc/get_debug_name()
	return "[src.type]"

/datum/proc/get_log_name()
	return "[src.type]"

/datum/atom/Destroy()

	if(!finalized)
		log_error("Warning: [get_debug_name()] is being destroyed before it is finalized!")

	return ..()