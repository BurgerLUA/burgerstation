SUBSYSTEM_DEF(delete)
	name = "Cleanup Subsystem"
	desc = "Cleans up things that need to be deleted."
	priority = SS_ORDER_DELETE
	tick_rate = SECONDS_TO_TICKS(1)
	var/list/objects_to_delete = list()

/subsystem/delete/on_life()

	for(var/datum/object_to_delete in objects_to_delete)

		if(object_to_delete.qdeleting)
			objects_to_delete -= object_to_delete
			continue

		var/time_to_delete = objects_to_delete[object_to_delete]
		if(time_to_delete > world.time)
			continue

		objects_to_delete -= object_to_delete
		qdel(object_to_delete)


	return TRUE

proc/queue_delete(var/object_to_delete,var/delete_in = 1)
	SSdelete.objects_to_delete[object_to_delete] = world.time + delete_in

proc/undelete(var/datum/object_to_delete)

	if(!SSdelete.objects_to_delete[object_to_delete])
		return FALSE

	SSdelete.objects_to_delete -= object_to_delete

	return TRUE



