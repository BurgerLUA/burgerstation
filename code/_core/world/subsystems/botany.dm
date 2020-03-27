var/global/list/plant_type/all_plant_types = list()

SUBSYSTEM_DEF(botany)
	name = "Botany Subsystem"
	desc = "Handle botany related matters."
	tick_rate = SECONDS_TO_TICKS(4)
	priority = SS_ORDER_PRELOAD


/subsystem/botany/on_life()

	for(var/obj/structure/interactive/plant/P in all_plants)
		P.on_life()

	return TRUE

/subsystem/botany/Initialize()
	for(var/k in subtypesof(/plant_type/))
		var/plant_type/P = k
		var/p_id = initial(P.id)
		if(p_id)
			P = new k
			all_plant_types[p_id] = P

	log_subsystem(name,"Found [length(all_plant_types)] plant types.")

	return TRUE