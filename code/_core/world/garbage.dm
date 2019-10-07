var/list/qdel_refs_to_type = list()

//Credit to Kachnov for this garbage collection code.
/datum/
	var/name
	var/id
	var/desc
	var/desc_extended
	var/qdeleting = FALSE

/datum/proc/destroy()
	tag = null // required to GC
	return TRUE

/proc/qdel(var/datum/object)

	if(is_datum(object))

		if(!object.qdel_warning)
			object.qdel_attempts += 1
			if(object.qdel_attempts >= 5)
				object.qdel_warning = TRUE
				LOG_ERROR("WARNING: Object of type [object.type](Name: [object.name], ID:[object.id]) was queued for delete [object.qdel_attempts] times!")

		if(!object.qdeleting)
			object.qdeleting = TRUE
			qdel_refs_to_type["\ref[object]"] = object.type

			if(!object.destroy())
				LOG_ERROR("WARNING! Object of type [object.type] did not have a proper destroy call!")

			return TRUE


	return FALSE