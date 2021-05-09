var/global/dmm_suite/dmm_suite

SUBSYSTEM_DEF(dmm_suite)
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

	var/map_name
	var/map_path
	var/list/z_level_to_file = list()

	var/list/prefab_markers = list()


	var/list/valid_prefabs = list(
		"64x64" = list(
			"maps/prefabs/64x64/clockwork.dmm",
			"maps/prefabs/64x64/cult.dmm",
			"maps/prefabs/64x64/xeno.dmm"
		),
		"32x32" = list(
			"maps/prefabs/32x32/rng_shrine.dmm",
			"maps/prefabs/32x32/hierophant.dmm",
			"maps/prefabs/32x32/goblin_king.dmm",
			"maps/prefabs/32x32/frog.dmm"
		),
		"16x16" = list(
			//"maps/prefabs/16x16/abnormality.dmm"
		),
		"antag" = list(
			"maps/prefabs/antag/rev_compound.dmm",
			"maps/prefabs/antag/syndicate_ship.dmm"
		)
	)

	var/list/maps_to_load = list(
		"maps/core/z_02.dmm",
		"maps/core/z_01.dmm",
		"maps/core/burgerstation.dmm",
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
	log_subsystem(name,"Found [length(valid_prefabs)] valid prefab sets.")
	var/loaded_prefabs = 0
	for(var/dimensions in prefab_markers)
		log_subsystem(name,"Found [length(prefab_markers[dimensions])] valid maps for dimension set [dimensions].")
		for(var/k in prefab_markers[dimensions])
			if(!length(valid_prefabs[dimensions]))
				break
			var/obj/marker/M = k
			var/chosen_file = pick(valid_prefabs[dimensions])
			valid_prefabs[dimensions] -= chosen_file
			var/map_contents = file2text(chosen_file)
			log_subsystem("Loading [chosen_file]...")
			dmm_suite.read_map(map_contents,M.x,M.y,M.z)
			qdel(M)
			loaded_prefabs++

	log_subsystem(name,"Loaded [loaded_prefabs] prefabs.")

	return ..()

