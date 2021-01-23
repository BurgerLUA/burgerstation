SUBSYSTEM_DEF(delete)
	name = "Cleanup Subsystem"
	desc = "Cleans up things that need to be deleted."
	priority = SS_ORDER_DELETE
	tick_rate = SECONDS_TO_TICKS(4)
	var/list/objects_to_delete = list()
	var/list/objects_to_delete_safe = list()

	cpu_usage_max = 50
	tick_usage_max = 50

	var/max_deletions = 50

	var/list/cleaning_log = list()

/subsystem/delete/unclog(var/mob/caller)

	for(var/k in src.objects_to_delete)
		var/datum/D = k
		objects_to_delete -= k
		qdel(D)

	for(var/k in src.objects_to_delete_safe)
		var/datum/D = k
		objects_to_delete -= k
		qdel(D)

	broadcast_to_clients(span("danger","Force deleted all objects queued for deletion."))

	return ..()

/subsystem/delete/on_life()

	var/i=0

	for(var/k in objects_to_delete_safe)
		var/datum/object_to_delete = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)
		if(!istype(object_to_delete) || object_to_delete.qdeleting)
			objects_to_delete_safe -= k
			continue

		var/time_to_delete = objects_to_delete_safe[k]
		if(time_to_delete > world.time)
			continue

		if(!should_delete(object_to_delete))
			objects_to_delete_safe[k] = world.time + ITEM_DELETION_TIME_NEW
			continue

		objects_to_delete_safe -= k
		objects_to_delete -= k
		cleaning_log += "Safe deleted [object_to_delete.get_debug_name()]."
		qdel(object_to_delete)
		i++
		if(i >= max_deletions)
			break

	for(var/k in objects_to_delete)
		var/datum/object_to_delete = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)

		if(object_to_delete.qdeleting)
			objects_to_delete -= k
			continue

		var/time_to_delete = objects_to_delete[k]
		if(time_to_delete > world.time)
			continue

		if(is_atom(k))
			var/atom/A = k
			if(!A.is_safe_to_delete())
				objects_to_delete[k] = world.time + ITEM_DELETION_TIME_NEW
				continue

		objects_to_delete -= k
		objects_to_delete_safe -= k
		cleaning_log += "Deleted [object_to_delete.get_debug_name()]."
		qdel(object_to_delete)
		i++
		if(i >= max_deletions)
			break

	/*
	var/queued_objects_to_delete = length(objects_to_delete)
	var/queued_objects_to_delete_safe = length(objects_to_delete_safe)

	if(queued_objects_to_delete >= 1000)
		var/limit = 100
		log_error("Cleaning System Warning: objects_to_delete is execeding 1000 queued objects ([queued_objects_to_delete]) to delete! Force deleting [limit] of the oldest entrys...")

		for(var/k in objects_to_delete)
			var/datum/D = k
			CHECK_TICK(100,FPS_SERVER)
			qdel(D)
			objects_to_delete -= k
			limit--
			if(limit <= 0)
				break

	if(queued_objects_to_delete_safe >= 1000)
		var/limit = 100
		log_error("Cleaning System Warning: objects_to_delete_safe is execeding 1000 queued objects ([queued_objects_to_delete_safe]) to delete! Force deleting [limit] of the oldest entrys...")
		for(var/k in objects_to_delete_safe)
			var/datum/D = k
			CHECK_TICK(100,FPS_SERVER)
			qdel(D)
			objects_to_delete -= k
			limit--
			if(limit <= 0)
				break
	*/

	return TRUE

/subsystem/delete/proc/should_delete(var/datum/D)

	if(!is_atom(D))
		log_error("Warning: Tried safe deleting a non-atom! ([D.get_debug_name()]).")
		return TRUE
	else
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

	if(object_to_delete.queue_delete_immune)
		return FALSE

	if(object_to_delete.qdeleting)
		return FALSE

	if(safe)
		SSdelete.objects_to_delete_safe[object_to_delete] = (world.time + delete_in)
	else
		SSdelete.objects_to_delete[object_to_delete] = (world.time + delete_in)

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



