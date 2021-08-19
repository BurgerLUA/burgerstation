var/global/dmm_suite/dmm_suite

#define PREFABS_DIR "maps/prefabs/"

SUBSYSTEM_DEF(dmm_suite)
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

	var/map_name
	var/map_path
	var/list/z_level_to_file = list()

	var/list/prefab_markers = list()

	var/list/valid_prefabs = list()

	var/list/maps_to_load = list(
		"maps/jungle/z_03.dmm",
		"maps/jungle/z_02.dmm",
		"maps/jungle/z_01.dmm",
		"maps/_core/station.dmm",
		"maps/_core/station_above.dmm",
		"maps/_core/bluespace.dmm"
	)

/subsystem/dmm_suite/Initialize()

	dmm_suite = new()

	//Load all the maps.
	for(var/i=1,i<=length(maps_to_load),i++)
		var/k = maps_to_load[i]
		var/map_file = rustg_file_read(k)
		dmm_suite.read_map(map_file,1,1,i)
		log_subsystem(name,"Loaded [k].")
		z_level_to_file["[i]"] = k

	//Load prefabs
	for(var/category in flist(PREFABS_DIR))
		category = copytext(category,1,-1)
		for(var/file in flist("[PREFABS_DIR][category]/"))
			if(!has_suffix(file,".dmm"))
				continue
			if(!valid_prefabs[category])
				valid_prefabs[category] = list()
			log_subsystem(src.name,"Adding prefab [PREFABS_DIR][category]/[file] to [category].")
			valid_prefabs[category] += "[PREFABS_DIR][category]/[file]"

	log_subsystem(name,"Found [length(valid_prefabs)] valid prefab sets.")
	var/loaded_prefabs = 0
	for(var/category in prefab_markers)
		log_subsystem(name,"Found [length(prefab_markers[category])] valid maps for dimension set [category].")
		for(var/k in prefab_markers[category]) //For each maker...
			var/obj/marker/prefab/M = k
			if(!length(valid_prefabs[category]))
				log_error("Warning: Not enough prefabs of type [category] to satisfy all prefab markers.")
				break
			var/list/local_prefabs = valid_prefabs[category]
			if(length(M.prefabs))
				local_prefabs = local_prefabs & M.prefabs
			if(length(local_prefabs))
				var/chosen_file = pick(local_prefabs)
				valid_prefabs[category] -= chosen_file
				var/map_contents = file2text(chosen_file)
				log_subsystem(name,"Loading [chosen_file]...")
				dmm_suite.read_map(map_contents,M.x,M.y,M.z)
				loaded_prefabs++
			qdel(M)

	log_subsystem(name,"Loaded [loaded_prefabs] prefabs.")

	return ..()

