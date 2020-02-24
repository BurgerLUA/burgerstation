var/global/list/loot/all_prefixes = list()

SUBSYSTEM_DEF(prefix)
	name = "Prefix Subsystem"
	desc = "Yes."
	priority = SS_ORDER_PRELOAD

/subsystem/prefix/Initialize()
	for(var/v in subtypesof(/prefix/))
		var/prefix/P = new v
		all_prefixes[P.id] = P

	LOG_SERVER("Initialized [length(all_prefixes)] prefixes.")