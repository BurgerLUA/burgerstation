var/global/list/all_damage_types = list()

/subsystem/damagetype/
	name = "Damage Type Subsystem"
	desc = "Stores all the known damage types in a list."
	priority = SS_ORDER_DAMAGETYPE

/subsystem/damagetype/on_life()

	for(var/A in subtypesof(/damagetype/))
		var/damagetype/D = new A
		all_damage_types[D.id] = D

	return FALSE