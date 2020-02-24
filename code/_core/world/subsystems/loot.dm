var/global/list/all_loot = list()

SUBSYSTEM_DEF(loot)
	name = "Loot Subsystem"
	desc = "Yes."
	priority = SS_ORDER_PRELOAD

/subsystem/loot/Initialize()
	for(var/v in subtypesof(/loot/))
		var/loot/L = new v
		all_loot[L.id] = L

	LOG_SERVER("Initialized [length(all_loot)] loot tables.")