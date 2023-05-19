SUBSYSTEM_DEF(botany)
	name = "Botany Subsystem"
	desc = "Handle botany related matters."
	tick_rate = SECONDS_TO_TICKS(20)
	priority = SS_ORDER_FIRST

	tick_usage_max = 50

	var/list/obj/structure/interactive/plant/all_plants = list()
	var/list/plant_type/all_plant_types = list()

/subsystem/botany/unclog(var/mob/caller)

	for(var/k in all_plants)
		var/obj/structure/interactive/plant/P = k
		all_plants -= k
		if(!P || P.qdeleting)
			continue
		qdel(P)

	. = ..()

/subsystem/botany/on_life()

	if(length(all_plants))
		var/plants_to_check = all_plants.Copy()
		var/desired_delay = tick_rate / length(plants_to_check)
		desired_delay = TICKS_TO_DECISECONDS(desired_delay)
		for(var/k in plants_to_check)
			var/obj/structure/interactive/plant/P = k
			if(!P || P.qdeleting)
				all_plants -= k
				continue
			if(P.on_life(tick_rate) == null)
				log_error("Warning! Plant [P.get_debug_name()] did not complete on_life() properly and thus was deleted.")
				qdel(P)
			sleep(desired_delay)

	return TRUE

/subsystem/botany/Initialize()
	for(var/k in subtypesof(/plant_type/))
		var/plant_type/P = k
		P = new k
		all_plant_types[P.type] = P

	log_subsystem(name,"Found [length(all_plant_types)] plant types.")

	return ..()
