var/global/list/experience/attribute/all_attributes = list()

SUBSYSTEM_DEF(attributes)
	name = "Attribute Subsystem"
	desc = "Stores all the known attributes in a list."
	priority = SS_ORDER_PRELOAD

/subsystem/attributes/Initialize()
	for(var/A in subtypesof(/experience/attribute/))
		all_attributes += A

	log_subsystem(name,"Initialized [length(all_attributes)] attributes.")