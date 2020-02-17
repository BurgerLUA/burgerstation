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
					LOG_ERROR("WARNING: Datum of type [object.type] was queued for delete [object.qdel_attempts] times!")

		if(!object.qdeleting)
			object.qdeleting = TRUE
			qdel_refs_to_type["\ref[object]"] = object.type

			if(!object.Destroy())
				LOG_ERROR("WARNING! Datum of type [object.type] did not have a proper destroy call!")

			return TRUE


	return FALSE