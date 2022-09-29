SUBSYSTEM_DEF(armor)
	name = "Armor Subsystem"
	desc = "Stores all the known armor datums in a list."
	priority = SS_ORDER_FIRST

	var/list/all_armors = list()

/subsystem/armor/Initialize()

	for(var/d in subtypesof(/armor/))
		var/armor/A = new d
		all_armors[A.type] = A

	log_subsystem(name,"Initialized [length(all_armors)] armor datums.")

	. = ..()