var/global/dmm_suite/dmm_suite

SUBSYSTEM_DEF(dmm_suite)
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

/subsystem/dmm_suite/Initialize()
	//Add the suite
	dmm_suite = new()

	//Load the world.

	var/list/map_files = flist(MAP_DIRECTORY)

	var/maps_loaded = 0

	for(var/filename in map_files)

		if(!has_suffix(filename,".dmm"))
			continue

		var/x_value = text2num(copytext(filename,1,2))
		var/y_value = text2num(copytext(filename,3,4))

		if(x_value <= 0 || y_value <= 0)
			continue

		LOG_SERVER("Loading [MAP_DIRECTORY][filename]...")

		var/file_data = file2text("[MAP_DIRECTORY]/[filename]")

		dmm_suite.read_map(file_data, 1 + (x_value-1)*WORLD_SIZE_SEGMENT, 1 + (y_value-1)*WORLD_SIZE_SEGMENT, 1)

		maps_loaded++

	var/prefabs_loaded = 0

	for(var/obj/marker/map/M in world)
		dmm_suite.read_map(file2text(M.map_file),M.x,M.y,M.z)
		M.post_map_load()
		prefabs_loaded++

	log_subsystem(name,"Loaded [prefabs_loaded] prefabs.")
	log_subsystem(name,"Loaded [maps_loaded] maps.")

