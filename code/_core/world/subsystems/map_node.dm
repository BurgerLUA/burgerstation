SUBSYSTEM_DEF(map_node)
	name = "Map Node Subsystem"
	desc = "Generates Map Nodes."
	priority = SS_ORDER_LAST

/subsystem/map_node/Initialize()

	log_subsystem("Node graph out of date. Rebuilding...")

	node_checker = new /mob/abstract/node_checker(locate(1,1,1))

	var/map_nodes = 0
	var/adjacent_map_nodes = 0

	for(var/k in all_map_nodes)
		var/obj/marker/map_node/M = k
		if(M.initialize_node())
			map_nodes += 1
			adjacent_map_nodes += length(M.adjacent_map_nodes)

	log_subsystem(name,"Initialized [map_nodes] valid map nodes with [adjacent_map_nodes] links.")

	var/list/found_remote_flight_consoles = list()
	for(var/obj/structure/interactive/computer/console/remote_flight/RF in world)
		found_remote_flight_consoles += get_turf(RF)

	var/valid_paths = 0
	var/error_paths = 0

	for(var/k1 in all_syndicate_spawns)
		var/turf/M = k1
		var/obj/marker/map_node/N_start = find_closest_node(M)
		if(!N_start)
			log_error("Could not find a valid path start location near [M.get_debug_name()]!")
			error_paths++
			continue
		for(var/k2 in found_remote_flight_consoles)
			var/turf/RF = k2
			if(RF.z != M.z)
				continue
			var/obj/marker/map_node/N_end = find_closest_node(RF)
			if(!N_end)
				log_error("Could not find a valid path end location near [RF.get_debug_name()]!")
				error_paths++
				continue
			var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
			if(!found_path)
				log_error("Could not find a valid path between  [M.get_debug_name()] and [RF.get_debug_name()]!")
				error_paths++
				continue
			valid_paths++

	log_subsystem(name,"Found [valid_paths] valid paths and [error_paths] bad paths.")















	return ..()
