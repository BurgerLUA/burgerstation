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

		if(object_to_delete.qdeleting)
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

	return TRUE

/subsystem/delete/proc/should_delete(var/datum/D)

	if(!is_atom(D))
		log_error("Warning: Tried safe deleting a non-atom! ([D.get_debug_name()]).")
		return TRUE

	var/atom/A = D
	if(!A.is_safe_to_delete())
		return FALSE

	if(!isturf(A.loc))
		return FALSE
	var/turf/atom_turf = A.loc

	var/area/atom_area = atom_turf.loc
	if(atom_area.safe_storage)
		return FALSE

	for(var/k in all_mobs_with_clients_by_z["[atom_turf.z]"])
		var/mob/M = k
		if(is_observer(M))
			continue
		var/regisred_distance = get_dist(A,M)
		if(regisred_distance <= VIEW_RANGE + ZOOM_RANGE)
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



