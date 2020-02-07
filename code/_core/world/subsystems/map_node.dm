/subsystem/map_node/
	name = "Map Node Subsystem"
	desc = "Generates Map Nodes."
	priority = SS_ORDER_LAST

/subsystem/map_node/Initialize()

	LOG_SERVER("Node graph out of date. Rebuilding...")

	var/map_nodes = 0
	var/adjacent_nodes = 0

	for(var/obj/map_node/M in all_map_nodes)
		M.initialize_node()
		adjacent_nodes += length(M.adjacent_nodes)
		map_nodes += 1

	LOG_SERVER("Initialized [map_nodes] map nodes with [adjacent_nodes] total adjacent nodes.")

