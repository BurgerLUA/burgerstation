SUBSYSTEM_DEF(ore)
	name = "Ore Subsystem"
	desc = "Spawns ore in the world."
	priority = SS_ORDER_LAST

/subsystem/ore/Initialize()

	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return TRUE

	var/spawned_ore_chunks = 0
	var/spawned_ore_chunks_deep = 0
	var/startturf = locate(1,1,SSdmm_suite.file_to_z_level["maps/_core/mission.dmm"])
	var/endturf = locate(world.maxx,world.maxy,world.maxz)
	for(var/turf/simulated/floor/S in block(startturf,endturf))
		if(!S.organic)
			continue
		if(SSdmm_suite.is_pvp_coord(S.x,S.y,S.z))
			if(prob(99.95))
				continue
			new /obj/marker/ore_deep(S)
			spawned_ore_chunks_deep++
		else
			if(prob(99.975))
				continue
			new /obj/marker/ore_deep(S)
			spawned_ore_chunks_deep++
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
	for(var/turf/simulated/wall/rock/S in block(startturf,endturf))
		if(!S.organic || !S.health)
			continue
		if(SSdmm_suite.is_pvp_coord(S.x,S.y,S.z))
			if(prob(97.5))
				continue
			new /obj/marker/ore(S)
			spawned_ore_chunks++
		else
			if(prob(99.75))
				continue
			new /obj/marker/ore(S)
			spawned_ore_chunks++
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
	log_subsystem(name,"Spawned [spawned_ore_chunks] ore chunks and [spawned_ore_chunks_deep] deep veins.")

	return TRUE
