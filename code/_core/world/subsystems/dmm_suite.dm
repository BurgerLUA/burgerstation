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


