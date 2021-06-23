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
		"maps/jungle/z_00.dmm",
		"maps/core/bluespace.dmm"
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
		valid_prefabs[category] = list()
		for(var/file in flist("[PREFABS_DIR][category]/"))
			if(!has_prefix(file,".dmm"))
				continue
			log_subsystem(src.name,"Adding prefab [PREFABS_DIR][category]/[file] to [category].")
			valid_prefabs[category] += "[PREFABS_DIR][category]/[file]"

	return ..()

	log_subsystem(name,"Found [length(valid_prefabs)] valid prefab sets.")
	var/loaded_prefabs = 0
	for(var/dimensions in prefab_markers)
		log_subsystem(name,"Found [length(prefab_markers[dimensions])] valid maps for dimension set [dimensions].")
		for(var/k in prefab_markers[dimensions])
			if(!length(valid_prefabs[dimensions]))
				log_error("Warning: Not enough prefabs of type [dimensions] to satisfy all prefab markers.")
				break
			var/obj/marker/prefab/M = k
			var/list/local_prefabs = length(M.prefabs) ? valid_prefabs[dimensions] & M.prefabs : valid_prefabs[dimensions]
			if(length(local_prefabs[dimensions]))
				var/chosen_file = pick(local_prefabs[dimensions])
				valid_prefabs[dimensions] -= chosen_file
				var/map_contents = file2text(chosen_file)
				log_subsystem("Loading [chosen_file]...")
				dmm_suite.read_map(map_contents,M.x,M.y,M.z)
				loaded_prefabs++
			qdel(M)

	log_subsystem(name,"Loaded [loaded_prefabs] prefabs.")

	return ..()

