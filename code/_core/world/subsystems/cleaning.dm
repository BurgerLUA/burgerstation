var/global/list/objects_to_delete = list()

SUBSYSTEM_DEF(delete)
	name = "Cleanup Subsystem"
	desc = "Cleans up things that need to be deleted."
	priority = SS_ORDER_DELETE
	tick_rate = SECONDS_TO_TICKS(1)

/subsystem/delete/on_life()

	for(var/datum/object_to_delete in objects_to_delete)

		if(object_to_delete.qdeleting)
			objects_to_delete -= object_to_delete
			continue

		var/time_to_delete = objects_to_delete[object_to_delete]
		if(time_to_delete > curtime)
			continue

		objects_to_delete -= object_to_delete

		qdel(object_to_delete)

	return TRUE

proc/queue_delete(var/object_to_delete,var/delete_in = 1)
	objects_to_delete[object_to_delete] = curtime + delete_in

proc/undelete(var/datum/object_to_delete)

	if(!objects_to_delete[object_to_delete])
		return FALSE

	objects_to_delete -= object_to_delete

	return TRUE



