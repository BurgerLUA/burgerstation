var/global/list/all_damage_types = list()

SUBSYSTEM_DEF(damagetype)
	name = "Damage Type Subsystem"
	desc = "Stores all the known damage types in a list."
	priority = SS_ORDER_PRELOAD

/subsystem/damagetype/Initialize()

	for(var/A in subtypesof(/damagetype/))
		var/damagetype/D = new A
		all_damage_types[D.type] = D

	log_subsystem(name,"Initialized [length(all_damage_types)] damage types.")


