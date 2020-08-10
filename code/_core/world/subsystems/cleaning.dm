SUBSYSTEM_DEF(delete)
	name = "Cleanup Subsystem"
	desc = "Cleans up things that need to be deleted."
	priority = SS_ORDER_DELETE
	tick_rate = SECONDS_TO_TICKS(1)
	var/list/objects_to_delete = list()
	var/list/objects_to_delete_safe = list()

	cpu_usage_max = 50
	tick_usage_max = 50

/subsystem/delete/on_life()

	for(var/k in objects_to_delete)
		var/datum/object_to_delete = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)
		if(object_to_delete.qdeleting)
			objects_to_delete -= object_to_delete
			continue
		var/time_to_delete = objects_to_delete[object_to_delete]
		if(time_to_delete > world.time)
			continue
		if(is_atom(object_to_delete))
			var/atom/A = object_to_delete
			if(!A.is_safe_to_delete())
				objects_to_delete[object_to_delete] = world.time + ITEM_DELETION_TIME_NEW
				continue

		objects_to_delete -= object_to_delete
		qdel(object_to_delete)


	for(var/k in objects_to_delete_safe) //Don't delete stuff if players are in view.
		var/datum/object_to_delete = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)
		if(!istype(object_to_delete) || object_to_delete.qdeleting)
			objects_to_delete_safe -= object_to_delete
			continue

		var/time_to_delete = objects_to_delete_safe[object_to_delete]
		if(time_to_delete > world.time)
			continue

		if(!should_delete(object_to_delete))
			objects_to_delete_safe[object_to_delete] = world.time + ITEM_DELETION_TIME_NEW
			continue

		objects_to_delete_safe -= object_to_delete
		qdel(object_to_delete)

	return TRUE

/subsystem/delete/proc/should_delete(var/datum/D)

	if(is_atom(D))
		var/atom/A = D
		if(!A.is_safe_to_delete())
			return FALSE
		if(!isturf(A.loc))
			return FALSE
		var/area/A2 = get_area(A)
		if(A2.safe_storage)
			return FALSE
		for(var/mob/living/advanced/player/P in viewers(VIEW_RANGE,get_turf(A)))
			if(!P.client)
				continue
			return FALSE

	return TRUE

proc/queue_delete(var/datum/object_to_delete,var/delete_in = 1,var/safe=FALSE)

	if(object_to_delete.qdelete_immune)
		return FALSE

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



