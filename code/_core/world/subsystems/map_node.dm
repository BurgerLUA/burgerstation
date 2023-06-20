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
		else
			qdel(M)
		CHECK_TICK_HARD

	log_subsystem(name,"Initialized [map_nodes] manual map nodes with [adjacent_map_nodes] links.")

	var/z = SSdmm_suite.file_to_z_level["maps/_core/mission.dmm"]

	var/list/auto_nodes = list()
	for(var/x=1,x<=world.maxx,x+=8) for(var/y=1,y<=world.maxy,y+=8)
		var/turf/T = locate(x,y,z)
		if(!T || T.has_dense_atom)
			continue
		var/obj/marker/map_node/M = locate() in range(5,T)
		if(M)
			CHECK_TICK_HARD
			continue
		M = new(T,TRUE)
		auto_nodes += M
		CHECK_TICK_HARD

	var/auto_map_nodes = 0
	var/adjacent_auto_map_nodes = 0

	for(var/k in auto_nodes)
		var/obj/marker/map_node/M = k
		if(M.initialize_node())
			auto_map_nodes += 1
			adjacent_auto_map_nodes += length(M.adjacent_map_nodes)
		else
			qdel(M)
		CHECK_TICK_HARD

	log_subsystem(name,"Initialized [auto_map_nodes] automatic map nodes with [adjacent_auto_map_nodes] links.")

	. = ..()
