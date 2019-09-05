var/global/list/all_reagents = list()

/subsystem/reagent/
	name = "Reagent Subsystem"
	desc = "Store all the reagents."
	priority = SS_ORDER_PRELOAD

/subsystem/reagent/Initialize()

	for(var/v in subtypesof(/reagent/))
		var/reagent/R = new v
		if(!R.id)
			LOG_ERROR("Reagent Subsystem Error: Reagent of type [R.type] has a null ID!")
			continue
		all_reagents[R.id] = v

	LOG_SERVER("Initialized [length(all_reagents)] reagents.")