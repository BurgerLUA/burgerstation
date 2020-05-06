SUBSYSTEM_DEF(delete)
	name = "Cleanup Subsystem"
	desc = "Cleans up things that need to be deleted."
	priority = SS_ORDER_DELETE
	tick_rate = SECONDS_TO_TICKS(1)
	var/list/objects_to_delete = list()
	var/list/objects_to_delete_safe = list()

/subsystem/delete/on_life()

	for(var/datum/object_to_delete in objects_to_delete)
		if(object_to_delete.qdeleting)
			objects_to_delete -= object_to_delete
			continue
		var/time_to_delete = objects_to_delete[object_to_delete]
		if(time_to_delete > world.time)
			continue
		if(is_atom(object_to_delete))
			var/atom/A = object_to_delete
			if(!A.is_safe_to_delete())
				objects_to_delete[object_to_delete] = world.time + 300 //Wait another 30 seconds.
				continue

		objects_to_delete -= object_to_delete
		qdel(object_to_delete)


	for(var/datum/object_to_delete in objects_to_delete_safe)

		if(!istype(object_to_delete) || object_to_delete.qdeleting)
			objects_to_delete_safe -= object_to_delete
			continue

		var/time_to_delete = objects_to_delete_safe[object_to_delete]
		if(time_to_delete > world.time)
			continue

		if(is_atom(object_to_delete))
			var/atom/A = object_to_delete
			if(!A.is_safe_to_delete())
				objects_to_delete_safe[object_to_delete] = world.time + 300
				continue

		var/should_delete = TRUE
		for(var/mob/living/advanced/player/P in viewers(VIEW_RANGE,get_turf(object_to_delete)))
			if(!P.client)
				continue
			should_delete = FALSE

		if(!should_delete)
			objects_to_delete_safe[object_to_delete] = world.time + 300
			continue

		objects_to_delete_safe -= object_to_delete
		qdel(object_to_delete)

	return TRUE

proc/queue_delete(var/object_to_delete,var/delete_in = 1,var/safe=FALSE)

	if(safe)
		SSdelete.objects_to_delete_safe[object_to_delete] = world.time + delete_in
	else
		SSdelete.objects_to_delete[object_to_delete] = world.time + delete_in

	return TRUE

proc/undelete(var/datum/object_to_delete)

	. = FALSE

	if(SSdelete.objects_to_delete[object_to_delete])
		SSdelete.objects_to_delete -= object_to_delete
		. = TRUE

	if(SSdelete.objects_to_delete_safe[object_to_delete])
		SSdelete.objects_to_delete_safe -= object_to_delete
		. = TRUE

	return .



