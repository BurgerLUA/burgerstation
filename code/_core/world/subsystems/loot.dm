var/global/list/loot/all_loot = list()

/subsystem/loot/
	name = "Loot Subsystem"
	desc = "Yes."
	priority = SS_ORDER_LOOT

/subsystem/loot/Initialize()
	for(var/v in subtypesof(/loot/))
		var/loot/L = new v
		all_loot[L.id] = L