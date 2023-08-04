SUBSYSTEM_DEF(class)
	name = "Class Subsystem"
	desc = "Stores all the known classes in a list."
	priority = SS_ORDER_FIRST

	var/list/all_classes = list()

/subsystem/class/Initialize()

	for(var/A in subtypesof(/class/))
		var/class/C = new A
		all_classes[C.type] = C

	log_subsystem(name,"Initialized [length(all_classes)] classes.")

	return ..()