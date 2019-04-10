var/global/dmm_suite/dmm_suite

/subsystem/dmm_suite/
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

/subsystem/dmm_suite/Initialize()
	//Add the suite
	dmm_suite = new()

	//Load the world.

	var/list/map_files = flist(MAP_DIRECTORY)

	for(var/filename in map_files)

		var/x_value = text2num(copytext(filename,1,2))
		var/y_value = text2num(copytext(filename,3,4))

		if(!ENABLE_MAPLOAD)
			if (!((x_value == 4 && y_value == 4) || (x_value == 3 && y_value == 2)))
				continue

		if(x_value <= 0 || y_value <= 0)
			continue

		LOG_SERVER("Loading [MAP_DIRECTORY][filename]...")

		var/file_data = file2text("[MAP_DIRECTORY]/[filename]")

		dmm_suite.read_map(file_data, 1 + (x_value-1)*WORLD_SIZE_SEGMENT, 1 + (y_value-1)*WORLD_SIZE_SEGMENT, 1)