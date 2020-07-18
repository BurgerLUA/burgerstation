var/global/dmm_suite/dmm_suite

SUBSYSTEM_DEF(dmm_suite)
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

/subsystem/dmm_suite/Initialize()

	//Add the suite

	dmm_suite = new()

	var/prefabs_loaded = 0

	for(var/obj/marker/map/M in world)
		dmm_suite.read_map(rustg_file_read(M.map_file),M.x,M.y,M.z)
		M.post_map_load()
		prefabs_loaded++

	log_subsystem(name,"Loaded [prefabs_loaded] map prefabs.")

	return ..()

