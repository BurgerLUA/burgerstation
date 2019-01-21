var/list/objects_to_delete = list()

/datum/subsystem/delete/
	name = "Class Subsystem"
	desc = "Stores all the known classes in a list."
	priority = SS_ORDER_DELETE
	tick_rate = 60

/datum/subsystem/delete/on_life()

	for(var/atom/object_to_delete in objects_to_delete)
		var/time_to_delete = objects_to_delete[object_to_delete]
		if(time_to_delete > curtime)
			continue

		del(object_to_delete)

	return TRUE

proc/queue_delete(var/object_to_delete,var/delete_in)
	objects_to_delete[object_to_delete] = curtime + delete_in