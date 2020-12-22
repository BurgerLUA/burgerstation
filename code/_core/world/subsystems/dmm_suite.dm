var/global/dmm_suite/dmm_suite

SUBSYSTEM_DEF(dmm_suite)
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

	var/map_name

/subsystem/dmm_suite/Initialize()

	dmm_suite = new()

	var/station_map = file2text("maps/core/burgerstation.dmm")
	dmm_suite.read_map(station_map,1,1,1)
	log_subsystem(name,"Loaded station map.")

	var/bluespace_map = file2text("maps/core/bluespace.dmm")
	dmm_suite.read_map(bluespace_map,1,1,2)
	log_subsystem(name,"Loaded bluespace map.")

	var/voted_map = "Island"
	if(rustg_file_exists(NEXT_MAP_FILE))
		var/found_map = trim(file2text(NEXT_MAP_FILE))
		log_debug("Found map: [found_map]...")
		if(found_map && horde_maps[found_map])
			voted_map = found_map
		else
			log_debug("Invalid map: [found_map]! Defaulting to [voted_map]...")

	log_debug("Found file: [horde_maps[voted_map]]...")
	var/ground_map = file2text(horde_maps[voted_map])
	dmm_suite.read_map(ground_map,1,1,3)
	log_subsystem(name,"Loaded ground map.")
	map_name = voted_map

	return ..()

