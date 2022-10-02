SUBSYSTEM_DEF(map_node)
	name = "Map Node Subsystem"
	desc = "Generates Map Nodes."
	priority = SS_ORDER_LAST

/subsystem/map_node/Initialize()

	log_subsystem(name,"Node graph out of date. Rebuilding...")

	var/map_nodes = 0
	var/adjacent_map_nodes = 0

	for(var/k in all_map_nodes)
		var/obj/marker/map_node/M = k
		if(M.initialize_node())
			map_nodes += 1
			adjacent_map_nodes += length(M.adjacent_map_nodes)
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

	log_subsystem(name,"Initialized [map_nodes] valid map nodes with [adjacent_map_nodes] links.")

	. = ..()
