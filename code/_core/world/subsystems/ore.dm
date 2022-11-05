SUBSYSTEM_DEF(ore)
	name = "Ore Subsystem"
	desc = "Spawns ore in the world."
	priority = SS_ORDER_LAST

/subsystem/ore/Initialize()

	if(CONFIG("ENABLE_INSTALOAD",FALSE))
		return TRUE

	var/spawned_ore_chunks = 0

	for(var/turf/simulated/floor/S in world)
		if(!S.organic)
			continue
		if(!prob(1))
			continue
		new /obj/structure/interactive/ore_deposit_ground/random(S)
		spawned_ore_chunks++
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

	for(var/turf/simulated/wall/rock/S in world)
		if(!S.organic || !S.health)
			continue
		if(!prob(1))
			continue
		new /obj/structure/interactive/ore_deposit/random(S)
		spawned_ore_chunks++
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

	log_subsystem(name,"Spawned [spawned_ore_chunks] ore chunks.")

	return TRUE