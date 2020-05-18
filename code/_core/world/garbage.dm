var/global/list/qdel_refs_to_type = list()

//Credit to Kachnov for this garbage collection code.
/datum/proc/Destroy()
	tag = null // required to GC
	return TRUE

/proc/qdel(var/datum/object)

	if(is_datum(object))
		if(!object.qdel_warning)
			object.qdel_attempts += 1
			if(object.qdel_attempts >= 2)
				object.qdel_warning = TRUE
				if(WARN_ON_DUPLICATE_QDEL)
					var/warning_message = "[object.get_debug_name()] was queued for delete [object.qdel_attempts] times!"
					CRASH_SAFE(warning_message)
					text2file(warning_message,GARBAGE_LOGS_PATH)

		if(!object.qdeleting)
			object.qdeleting = TRUE
			qdel_refs_to_type["\ref[object]"] = object.type
			if(!object.Destroy())
				var/warning_message = "[object.get_debug_name()] did not have a proper destroy call!"
				CRASH_SAFE(warning_message)
				text2file(warning_message,GARBAGE_LOGS_PATH)
			return TRUE

	return FALSE