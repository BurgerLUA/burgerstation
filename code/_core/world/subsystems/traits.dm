SUBSYSTEM_DEF(traits)
	name = "Traits"
	desc = "Stores all the known traits in a list."
	priority = SS_ORDER_LAST

	var/list/all_traits = list()

/subsystem/traits/Initialize()

	for(var/k in subtypesof(/trait/))
		var/trait/T = new k
		all_traits[T.id] = T

	log_subsystem(name,"Stored [length(all_traits)] traits.")

	return ..()