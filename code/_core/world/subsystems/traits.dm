SUBSYSTEM_DEF(traits)
	name = "Traits"
	desc = "Stores all the known traits in a list."
	priority = SS_ORDER_LAST

	var/list/all_traits = list()

/subsystem/traits/Initialize()

	for(var/k in subtypesof(/trait/))
		var/trait/T = k
		if(!initial(T.name))
			continue
		T = new k
		all_traits[T.type] = T

	log_subsystem(name,"Stored [length(all_traits)] traits.")

	return ..()