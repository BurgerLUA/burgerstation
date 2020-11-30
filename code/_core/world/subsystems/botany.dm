SUBSYSTEM_DEF(botany)
	name = "Botany Subsystem"
	desc = "Handle botany related matters."
	tick_rate = SECONDS_TO_TICKS(4)
	priority = SS_ORDER_PRELOAD

	tick_usage_max = 75
	cpu_usage_max = 75

	var/list/obj/structure/interactive/plant/all_plants = list()
	var/list/plant_type/all_plant_types = list()

/subsystem/botany/unclog(var/mob/caller)
	for(var/k in all_plants)
		var/obj/structure/interactive/plant/P = k
		qdel(P)
	broadcast_to_clients(span("danger","Deleted all plants."))

	return ..()

/subsystem/botany/on_life()

	for(var/k in all_plants)
		var/obj/structure/interactive/plant/P = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*5)
		if(P.on_life() == null)
			log_error("Warning! Plant [P.get_debug_name()] did not complete on_life() properly and thus was deleted.")
			qdel(P)

	return TRUE

/subsystem/botany/Initialize()
	for(var/k in subtypesof(/plant_type/))
		var/plant_type/P = k
		P = new k
		all_plant_types[P.type] = P

	log_subsystem(name,"Found [length(all_plant_types)] plant types.")

	return ..()