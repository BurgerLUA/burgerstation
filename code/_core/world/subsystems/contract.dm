SUBSYSTEM_DEF(contract)
	name = "Contract Subsystem"
	desc = "Store all the possible contract types."
	priority = SS_ORDER_PRELOAD
	var/list/contract/all_contracts = list()

/subsystem/contract/Initialize()

	for(var/k in subtypesof(/contract/))
		var/contract/C = k
		if(initial(C.amount) <= 0)
			continue
		C = new k
		all_contracts[C.type] = C

	log_subsystem(name,"Initialized [length(all_contracts)] contract types.")

	return ..()