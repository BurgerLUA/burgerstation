SUBSYSTEM_DEF(botany_alchemy)
	name = "Alchemy Plants Subsystem"
	desc = "Spawns and Manages Alchemy type plants."
	priority = SS_ORDER_LAST
	var/list/obj/structure/interactive/alchemy_plant/all_alchemy_plants = list()
	var/list/obj/marker/alchemy_plant/all_alchemy_plant_types = list()
/subsystem/botany_alchemy/Initialize()
	var/total_alchemy_plants = 0
	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return TRUE
	for(var/k in subtypesof(/obj/marker/alchemy_plant/))
		var/obj/marker/alchemy_plant/P = k
		P = new k
		all_alchemy_plant_types[P.type] = P
	log_subsystem(name,"Found [length(all_alchemy_plant_types)] markers for an alchemy plant.")

	var/startturf = locate(1,1,SSdmm_suite.file_to_z_level["maps/_core/mission.dmm"])
	var/endturf = locate(world.maxx,world.maxy,world.maxz)
	for(var/turf/simulated/floor/S in block(startturf,endturf))
		if(prob(97.5))// Check if we are going to spawn a plant before more complex checks.
			continue
		var/plant_here = FALSE
		var/lefttocheck = all_alchemy_plant_types.len
		for(var/atype in all_alchemy_plant_types)
			if(plant_here)
				continue
			var/obj/marker/alchemy_plant/P = new atype
			var/allowed_to_spawn = FALSE
			for(var/T in P.allowed_turfs)
				if(istype(S,T))
					allowed_to_spawn = TRUE
					break
			if(allowed_to_spawn && prob((1/lefttocheck)*100)) // My math is crap, but should give each type a roughy equal chance of spawning
				new P.type(S)
				total_alchemy_plants++
				lefttocheck--
				plant_here = TRUE
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
	log_subsystem(name,"Generated [total_alchemy_plants] total alchemy plants in world.")
	return TRUE

/subsystem/botany_alchemy/unclog(var/mob/caller)
	for(var/k in all_alchemy_plants)
		var/obj/structure/interactive/alchemy_plant/P = k
		qdel(P)
	broadcast_to_clients(span("danger","Deleted all alchemy plants."))

	return ..()

/subsystem/botany_alchemy/on_life()

	for(var/k in all_alchemy_plants)
		var/obj/structure/interactive/alchemy_plant/P = k
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER*5)
		if(P.on_life(tick_rate) == null)
			log_error("Warning! Plant [P.get_debug_name()] did not complete on_life() properly and thus was deleted.")
			qdel(P)

	return TRUE