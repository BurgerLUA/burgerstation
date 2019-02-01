var/global/list/all_classes = list()

/subsystem/classes/
	name = "Class Subsystem"
	desc = "Stores all the known classes in a list."
	priority = SS_ORDER_CLASS

/subsystem/classes/on_life()

	for(var/A in subtypesof(/class/))
		var/class/C = new A
		all_classes[C.id] = C

	return FALSE