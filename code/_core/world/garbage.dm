var/global/list/qdel_refs_to_type = list()

//Credit to Kachnov for this garbage collection code.
/datum/proc/Destroy()
	tag = null // required to GC
	return TRUE

/proc/qdel(var/datum/object)

	if(is_datum(object))
		var/do_crash = FALSE
		if(!object.qdel_warning)
			object.qdel_attempts += 1
			if(object.qdel_attempts >= 2)
				object.qdel_warning = TRUE
				if(WARN_ON_DUPLICATE_QDEL)
					var/warning_message = "Datum of type [object.type] was queued for delete [object.qdel_attempts] times!"
					log_error(warning_message)
					text2file(warning_message,GARBAGE_LOGS_PATH)
					if(CRASH_ON_DUPLICATE_QDEL)
						do_crash = TRUE

		if(!object.qdeleting)
			object.qdeleting = TRUE
			qdel_refs_to_type["\ref[object]"] = object.type
			if(!object.Destroy())
				var/warning_message = "Datum of type [object.type] did not have a proper destroy call!"
				log_error(warning_message)
				text2file(warning_message,GARBAGE_LOGS_PATH)
			return TRUE

		if(do_crash)
			CRASH_SAFE("Datum of type [object.type] was queued for delete [object.qdel_attempts] times!")





	return FALSE