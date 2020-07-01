SUBSYSTEM_DEF(loot)
	name = "Loot Subsystem"
	desc = "Yes."
	priority = SS_ORDER_PRELOAD
	var/list/all_loot = list()

/subsystem/loot/Initialize()

	for(var/v in subtypesof(/loot/))
		var/loot/L = new v
		all_loot[L.type] = L

	log_subsystem(name,"Initialized [length(all_loot)] loot tables.")

	return ..()