var/global/list/all_loot = list()

/subsystem/loot/
	name = "Loot Subsystem"
	desc = "Yes."
	priority = SS_ORDER_NORMAL

/subsystem/loot/Initialize()
	LOG_SERVER("STARTING LOOT SUBSYSTEM")
	for(var/v in subtypesof(/loot/))
		var/loot/L = new v
		all_loot[L.id] = L