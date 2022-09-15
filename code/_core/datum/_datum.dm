/datum/
	var/qdel_warning = 0
	var/qdel_warning_time = FALSE
	var/qdeleting = FALSE
	var/queue_delete_immune = FALSE
	var/list/hooks

/datum/proc/get_examine_list(var/mob/examiner)
	return list(div("examine_title","[src]"),div("examine_description","[src.type]"))

/datum/proc/get_examine_details_list(var/mob/examiner)
	return list()

/datum/proc/delete()
	qdel(src)
	return TRUE

/datum/Destroy()
	HOOK_CALL("Destroy")
	hooks?.Cut()
	. = ..()

/datum/proc/get_debug_name()
	return "[src.type]"

/datum/proc/get_log_name()
	return "[src.type]"