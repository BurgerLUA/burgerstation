//Credit to Kachnov for this garbage collection code.
/datum/
	var/qdeleting = FALSE

/datum/proc/destroy()
	tag = null // required to GC
	return TRUE

/atom/destroy()
	invisibility = 101
	return ..()

/atom/movable/destroy()
	loc = null
	return ..()

/mob/destroy()
	key = null // required to GC
	return ..()

/proc/qdel(var/datum/object)
	if(is_datum(object))

		if(!object.qdel_warning)
			object.qdel_attempts += 1
			if(object.qdel_attempts >= 5)
				object.qdel_warning = TRUE
				LOG_ERROR("WARNING: Object of type [object.type] was queued for delete [object.qdel_attempts] times!")

		if(!object.qdeleting)
			object.qdeleting = TRUE
			object.destroy()
			return TRUE
	return FALSE