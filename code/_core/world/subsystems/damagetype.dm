var/global/list/all_damage_types = list()

/subsystem/damagetype/
	name = "Damage Type Subsystem"
	desc = "Stores all the known damage types in a list."
	priority = SS_ORDER_PRELOAD

/subsystem/damagetype/Initialize()
	for(var/A in subtypesof(/damagetype/))
		var/damagetype/D = new A
		if(D.id)
			all_damage_types[D.id] = D
			world.log << D.id
		else
			qdel(D)

	LOG_SERVER("Initialized [length(all_damage_types)] damage types.")


