var/global/list/loot/all_prefixes = list()

/subsystem/prefix/
	name = "Prefix Subsystem"
	desc = "Yes."
	priority = SS_ORDER_NORMAL

/subsystem/prefix/Initialize()
	for(var/v in subtypesof(/prefix/))
		var/prefix/P = new v
		all_prefixes[P.id] = P