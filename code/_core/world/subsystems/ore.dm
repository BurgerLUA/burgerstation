SUBSYSTEM_DEF(ore)
	name = "Ore Subsystem"
	desc = "Initialize objs after they are made. Also handles queued object smoothing."
	priority = SS_ORDER_LAST

/subsystem/ore/Initialize()

	var/spawned_ore_chunks = 0

	for(var/turf/simulated/floor/S in world)
		if(!S.organic)
			continue
		if(!prob(1))
			continue
		var/obj/structure/interactive/ground_ore_deposit/map/random/GOD = new(S)
		INITIALIZE(GOD)
		GENERATE(GOD)
		spawned_ore_chunks++

	for(var/turf/simulated/wall/rock/S in world)
		if(!S.organic || !S.health)
			continue
		if(!prob(1))
			continue
		var/obj/structure/interactive/wall_ore_deposit/map/random/WOD = new(S)
		INITIALIZE(WOD)
		GENERATE(WOD)
		FINALIZE(WOD)
		spawned_ore_chunks++

	log_subsystem(name,"Spawned [spawned_ore_chunks] ore chunks.")

	return ..()