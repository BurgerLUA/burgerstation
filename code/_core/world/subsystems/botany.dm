SUBSYSTEM_DEF(botany)
	name = "Botany Subsystem"
	desc = "Handle botany related matters."
	tick_rate = LIFE_TICK_SLOW
	priority = SS_ORDER_PRELOAD

	tick_usage_max = 50

	var/list/obj/structure/interactive/plant/all_plants = list()
	var/list/plant_type/all_plant_types = list()

	var/list/queued_plant_update_chunks = list()

/subsystem/botany/unclog(var/mob/caller)

	for(var/k in all_plants)
		var/obj/structure/interactive/plant/P = k
		all_plants -= k
		if(!P || P.qdeleting)
			continue
		qdel(P)

	. = ..()

/subsystem/botany/on_life()

	for(var/ch in queued_plant_update_chunks)
		var/chunk/C1 = ch
		queued_plant_update_chunks -= ch
		for(var/j in C1.plants)
			var/obj/structure/interactive/plant/A = j
			if(!A.active && !A.dead) A.set_active(TRUE)
		for(var/k in C1.adjacent_chunks)
			var/chunk/C2 = k
			for(var/j in C2.plants)
				var/obj/structure/interactive/plant/A = j
				if(!A.active && !A.dead) A.set_active(TRUE)

	for(var/k in all_plants)
		var/obj/structure/interactive/plant/P = k
		if(!P)
			log_error("Warning: A NULL plant was found in the botany plants list!")
			all_plants -= k
			continue
		if(P.qdeleting)
			log_error("Warning: [P.get_debug_name()] was marked as qdeleting, despite being in the all_plants list!")
			all_plants -= k
			continue
		if(!P.active)
			log_error("Warning: [P.get_debug_name()] was marked as inactive, despite being in the all_plants list!")
			all_plants -= k
			continue
		if(P.on_life(tick_rate) == null)
			log_error("Warning! Plant [P.get_debug_name()] did not complete on_life() properly, and thus was deleted.")
			qdel(P)
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE

/subsystem/botany/Initialize()

	for(var/k in subtypesof(/plant_type/))
		var/plant_type/P = k
		P = new k
		P.value = 0
		for(var/r_id in P.reagents)
			var/reagent/R = REAGENT(r_id)
			P.value += R.value * P.reagents[r_id]
		P.value = CEILING(P.value,1)
		all_plant_types[P.type] = P

	log_subsystem(name,"Found [length(all_plant_types)] plant types.")

	return ..()
