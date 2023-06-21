var/global/dmm_suite/dmm_suite

#define PREFABS_DIR "maps/prefabs/"

SUBSYSTEM_DEF(dmm_suite)
	name = ".dmm Suite Subsystem"
	desc = "Map loading and saving."
	priority = SS_ORDER_DMM

	var/map_name
	var/map_path
	var/list/z_level_to_file = list()
	var/list/file_to_z_level = list()

	var/list/prefab_markers = list()

	var/list/valid_prefabs = list()

	var/list/linked_prefabs_below = list()
	var/list/linked_prefabs_above = list()

	var/list/maps_to_load = list(
		list(
			"size"=500,
			"turf"=/turf/unsimulated/dynamic_rock_gen,
			"area"=/area/mission/below
		),
		"maps/_core/mission.dmm",
		"maps/_core/bluespace.dmm",
		"maps/_core/station.dmm"
	)

	var/list/map_to_parallax = list(
		"maps/_core/bluespace.dmm" = 'icons/obj/effects/parallax_bluespace.dmi',
		"maps/_core/station.dmm" = 'icons/obj/effects/parallax.dmi'
	)

	var/list/map_to_final_destruction_turf = list(
		"maps/_core/mission.dmm" = /turf/simulated/openspace,
		"maps/_core/bluespace.dmm" = /turf/bluespace,
		"maps/_core/station.dmm" =  null
	)

	var/pvp_y
	var/pvp_coef

	var/list/possible_rogue_crewmembers = list()

/subsystem/dmm_suite/Initialize()

	dmm_suite = new()

	for(var/k in subtypesof(/mob/living/advanced/npc/unique/rogue))
		possible_rogue_crewmembers += k

	//Load all the maps.
	var/maps_loaded = 0
	for(var/i=1,i<=length(maps_to_load),i++)
		var/benchmark = true_time()
		var/k = maps_to_load[i]
		if(islist(k))
			if(!k["size"])
				log_error("WARNING: MISSING SIZE VARIABLE FOR MAP [i]!")
				continue
			if(!k["turf"])
				log_error("WARNING: MISSING TURF VARIABLE FOR MAP [i]!")
				continue
			if(!k["area"])
				log_error("WARNING: MISSING AREA VARIABLE FOR MAP [i]!")
				continue
			if(world.maxx < k["size"])
				world.maxx = k["size"]
				log_debug("X level increased to [world.maxx].")
			if(world.maxy < k["size"])
				world.maxy = k["size"]
				log_debug("Y level increased to [world.maxy].")
			var/list/block_turfs = block(locate(1,1,i),locate(k["size"],k["size"],i))
			for(var/j in block_turfs)
				var/turf/T = j
				var/area/NA = k["area"]
				if(T.x == 1 || T.x == k["size"] || T.y == 1 || T.y == k["size"])
					var/turf/NT = /turf/simulated/wall/rock/indestructable
					new NT(T)
					new NA(T)
				else
					var/turf/NT = k["turf"]
					new NT(T)
					new NA(T)
			z_level_to_file += "\ref[k]"
			file_to_z_level["\ref[k]"] = i
			maps_loaded++
			benchmark = true_time() - benchmark
			log_subsystem(src.name,"Loading generated z-level with [length(block_turfs)] turfs took [DECISECONDS_TO_SECONDS(benchmark)] seconds.")
		else
			var/map_file = rustg_file_read(k)
			dmm_suite.read_map(map_file,1,1,i,tag="[k]")
			z_level_to_file += k
			file_to_z_level["[k]"] = i
			maps_loaded++
			benchmark = true_time() - benchmark
			log_subsystem(src.name,"Loading [k] took [DECISECONDS_TO_SECONDS(benchmark)] seconds.")
			CHECK_TICK_HARD

	log_subsystem(src.name,"Loaded [maps_loaded] z-levels.")

	//Load prefabs
	for(var/category in flist(PREFABS_DIR))
		category = copytext(category,1,-1)
		for(var/file in flist("[PREFABS_DIR][category]/"))
			if(!has_suffix(file,".dmm"))
				continue
			if(has_suffix(file,"_below.dmm"))
				var/linked_file = replacetextEx(file,"_below.dmm",".dmm")
				linked_prefabs_below["[PREFABS_DIR][category]/[linked_file]"] = "[PREFABS_DIR][category]/[file]"
			else if(has_suffix(file,"_above.dmm"))
				var/linked_file = replacetextEx(file,"_above.dmm",".dmm")
				linked_prefabs_above["[PREFABS_DIR][category]/[linked_file]"] = "[PREFABS_DIR][category]/[file]"
			else
				if(!valid_prefabs[category])
					valid_prefabs[category] = list()
				valid_prefabs[category] += "[PREFABS_DIR][category]/[file]"

	log_subsystem(name,"Found [length(valid_prefabs)] valid prefab sets.")
	var/loaded_prefabs = 0

	var/list/not_enough = list()

	shuffle_inplace(prefab_markers)

	while(length(prefab_markers))
		var/obj/marker/prefab/M = prefab_markers[1]
		prefab_markers -= M
		M.prepare_prefab()
		if(!length(valid_prefabs[M.category]))
			if(!not_enough[M.category])
				not_enough[M.category] = 1
			else
				not_enough[M.category] += 1
			continue
		var/list/local_prefabs = valid_prefabs[M.category].Copy()
		if(length(M.prefabs))
			local_prefabs = local_prefabs & M.prefabs
		if(!length(local_prefabs))
			if(!not_enough[M.category])
				not_enough[M.category] = 1
			else
				not_enough[M.category] += 1
			continue

		M.chosen_file = pick(local_prefabs)
		if(M.unique) valid_prefabs[M.category] -= M.chosen_file
		var/map_contents = rustg_file_read(M.chosen_file)
		var/desired_angle = 0
		switch(M.dir)
			if(SOUTH)
				desired_angle = 0
			if(WEST)
				desired_angle = 90
			if(NORTH)
				desired_angle = 180
			if(EAST)
				desired_angle = 270
		dmm_suite.read_map(
			map_contents,
			M.x + M.offset_x,
			M.y + M.offset_y,
			M.z,
			tag="[M.chosen_file]",
			angleOffset = SIMPLIFY_DEGREES(desired_angle)
		)
		if(linked_prefabs_below[M.chosen_file])
			M.chosen_file_below = linked_prefabs_below[M.chosen_file]
			var/chosen_map_contents = rustg_file_read(M.chosen_file_below)
			dmm_suite.read_map(
				chosen_map_contents,
				M.x + M.offset_x,
				M.y + M.offset_y,
				M.z-1,
				tag="[M.chosen_file_below]",
				angleOffset = SIMPLIFY_DEGREES(desired_angle)
			)
		if(linked_prefabs_above[M.chosen_file])
			M.chosen_file_above = linked_prefabs_above[M.chosen_file]
			var/chosen_map_contents = rustg_file_read(M.chosen_file_above)
			dmm_suite.read_map(
				chosen_map_contents,
				M.x + M.offset_x,
				M.y + M.offset_y,
				M.z+1,
				tag="[M.chosen_file_above]",
				angleOffset = SIMPLIFY_DEGREES(desired_angle)
			)
		loaded_prefabs++


		CHECK_TICK_HARD

	if(length(not_enough))
		log_error("Warning: Not enough prefabs to satisfy all prefab markers.")
		for(var/k in not_enough)
			log_error("[not_enough[k]] additional [k] prefabs required.")

	log_subsystem(name,"Loaded [loaded_prefabs] prefabs.")


	//https://www.desmos.com/calculator/c64q75jvne

	if(CONFIG("ENABLE_PVP_AREA",TRUE))

		pvp_y = 450+rand(0,25)
		pvp_coef = pvp_y*0.0015

		var/z = file_to_z_level["maps/_core/mission.dmm"]
		if(z)
			//First pass, checking prefabs it can slice.
			for(var/x=2,x<=499,x++)
				CHECK_TICK_HARD
				var/y = pvp_y - (x * 0.05 + sin(x*3))**(pvp_coef*2)
				y = FLOOR(y,1)
				var/turf/T = locate(x,y,z)
				if(!T)
					continue
				var/area/A = T.loc
				if(A.flags_area & FLAG_AREA_IMPORTANT)
					A.flags_area |= FLAG_AREA_NO_PVP_CHASM

			for(var/y=2,y<=499,y++)
				for(var/x=2,x<=499,x++)
					CHECK_TICK_HARD
					if(y < pvp_y - (x * 0.05 + sin(x*3))**(pvp_coef*2) - 3) //Bottom line
						continue
					if(y > pvp_y - (x * 0.05 + sin(x*3))**(pvp_coef*2) + 3) //Top line
						continue
					var/turf/T = locate(x,y,z)
					var/area/A = T.loc
					if(A.flags_area & FLAG_AREA_NO_PVP_CHASM)
						continue //Skip.
					for(var/k in T.contents)
						var/atom/movable/M = k
						qdel(M)
					new /turf/simulated/floor/chasm(T)
					new /area(T)

			var/bridge_prefab = rustg_file_read("maps/prefabs/pvp_bridge/bridge.dmm")

			var/desired_bridges = 3
			var/marker_attempts_left = 30

			while(marker_attempts_left > 0 && desired_bridges > 0)
				CHECK_TICK_HARD
				marker_attempts_left--
				var/marker_x = rand(50,450)
				var/marker_y = pvp_y - (marker_x * 0.05 + sin(marker_x*3))**(pvp_coef*2)
				marker_x = round(marker_x)
				marker_y = round(marker_y)

				var/turf/T1 = locate(marker_x-16,marker_y-16*2,z)
				if(!T1 || T1.loc.type != /area/)
					continue
				var/turf/T2 = locate(marker_x+16,marker_y+16*2,z)
				if(!T2 || T2.loc.type != /area/)
					continue

				var/bad_block=FALSE
				var/list/block_turfs = block(T1,T2)
				for(var/k in block_turfs)
					var/turf/T = k
					if(T.loc.type != /area/)
						bad_block = TRUE
						break
					if(T.density)
						break
				if(bad_block)
					continue

				dmm_suite.read_map(
					bridge_prefab,
					marker_x-16,
					marker_y-16,
					z,
					tag="pvp_bridge"
				)
				desired_bridges--

	shuffle_inplace(rogue_crewmember_markers)

	for(var/k in rogue_crewmember_markers)
		if(!length(possible_rogue_crewmembers))
			break
		var/obj/marker/rogue_crewmember_marker/M = k
		var/turf/T = get_turf(M)
		if(!T)
			continue
		if(is_pvp_coord(T.x,T.y,T.z))
			continue
		var/mob/living/L = pick(possible_rogue_crewmembers)
		possible_rogue_crewmembers -= L
		L = new L(T)

	return ..()


/subsystem/dmm_suite/proc/is_pvp_coord(var/x,var/y,var/z,var/distance=0)

	if(!pvp_y)
		return FALSE

	var/mission_z = file_to_z_level["maps/_core/mission.dmm"]

	if(!mission_z || z != mission_z)
		return FALSE

	if(y+distance < pvp_y - (x * 0.05 + sin(x*3))**(pvp_coef*2))
		return FALSE

	var/turf/T = locate(x,y,z)
	if(!T)
		return FALSE

	var/area/A = T.loc
	if(A.flags_area & FLAG_AREA_NO_PVP_CHASM)
		return FALSE

	return TRUE

//Here lies dead code.
//Annoying to work with and I don't have time to spend 6 months on this.
/*
/subsystem/dmm_suite/proc/generate_world(var/z=0)

	log_subsystem(name,"Generating world [z]...")

	if(z <= 0)
		CRASH("Bad Z level!")
		return FALSE

	//UNUSED Generation: https://www.desmos.com/calculator/hj1nskeotw

	//River Generation: https://www.desmos.com/calculator/wibgiygmfi
	var/river_skew = RAND_PRECISE(-0.3,0.3)
	var/river_x = rand(world.maxx*0.3,world.maxx*0.7)-river_skew*world.maxx*0.2
	var/river_down = rand(0,world.maxy) //Honestly doesn't matter.
	var/river_offset_1 = rand(80,100)
	var/river_offset_2 = rand(80,100)
	var/river_tension = RAND_PRECISE(3,5)*pick(-1,1)
	var/river_wiggle = RAND_PRECISE(3,5)*pick(-1,1)
	var/river_width = rand(4,12) //Width is actually double this.
	var/river_top_mod = RAND_PRECISE(-0.01 - river_width*0.001,0.2)
	#define RIVER_1 (x > river_x + sin((y-river_down)*river_tension - river_offset_1) * river_wiggle - river_width + (y*river_skew) - y*river_top_mod)
	#define RIVER_2 (x < river_x + sin((y-river_down)*river_tension + river_offset_2) * -river_wiggle + river_width + (y*river_skew) + y*river_top_mod)

	//Ocean and Beach Generation: https://www.desmos.com/calculator/wfpzji1e3v
	var/beach_bumps = RAND_PRECISE(1,2)
	var/beach_skew = RAND_PRECISE(-0.05,0.05)
	var/beach_line = rand(VIEW_RANGE*3+beach_skew*VIEW_RANGE*3,VIEW_RANGE*3)
	var/beach_wiggle = rand(12,18)-beach_bumps*2

	//Snow Generation: https://www.desmos.com/calculator/xfkatwdtzy
	var/snow_strength = rand(50,80) //Generally how far it reaches down the map.
	var/snow_stretch = rand(2,10)
	var/snow_bump = RAND_PRECISE(1,3)
	var/snow_variance = rand(400,800)

	//Indestructable Wall = INFINITY and BYOND
	//Walls = 0.75 and above.
	//Ground is between.
	//Water = 0.1 and below.

	var/noise_seed = rand(1,1000000)
	var/seed_resolution = max(world.maxx,world.maxy)

	for(var/x=1,x<=world.maxx,x++) for(var/y=1,y<=world.maxy,y++)

		var/noise_profile = text2num(rustg_noise_get_at_coordinates("[noise_seed]","[x / seed_resolution]","[y / seed_resolution]"))

		var/turf/generation/desired_generation_type = /turf/generation/forest
		var/desired_turf_height
		var/desired_turf_height_min = 0
		var/desired_turf_height_max = 1

		var/beach_formula = beach_line*abs(beach_skew) + beach_line + beach_wiggle*(1-abs(beach_skew*0.5))+(-beach_skew*seed_resolution*0.5)-sin(x * beach_bumps*(360/seed_resolution))*(beach_wiggle-beach_bumps)+x*beach_skew+(x**2)*0.0002-cos(x)*beach_wiggle*2

		//Ice generation
		if(y > world.maxy-snow_strength*0.2*sin(x*(360/seed_resolution)-snow_variance*0.2)*snow_bump+cos(x*snow_bump*(360/seed_resolution))*snow_stretch+(x-snow_strength)*0.1+snow_strength*0.4)
			desired_turf_height_min = 0
			desired_turf_height_max = 0.11
			desired_generation_type = /turf/generation/ice
		//Ocean generation
		else if(y < beach_formula)
			var/height_magic = 1 - ((beach_formula - y) / (beach_formula))
			desired_turf_height = height_magic*0.1
			desired_turf_height_min = 0
			desired_turf_height_max = 0.1
			desired_generation_type = /turf/generation/ocean
		//River generation
		else if(RIVER_1 && RIVER_2) //River.
			desired_turf_height_min = 0
			desired_turf_height_max = 0.1
			desired_generation_type = /turf/generation/river
		//Beach generation
		else if(y < beach_line + 40 + abs(-beach_skew*seed_resolution*(3/5))-sin(x*beach_bumps*(360/seed_resolution))*beach_wiggle + (x**2)*0.0002+cos(x+180)*beach_wiggle*2)
			desired_turf_height_min = 0.11
			desired_turf_height_max = 0.74
			desired_generation_type = /turf/generation/beach
		//Snow generation
		else if(y > world.maxy - snow_strength*0.75 - snow_stretch*2 - cos(x*(360/seed_resolution)*snow_bump)*snow_stretch - sin((x+snow_variance)*(360/seed_resolution))*snow_stretch*1.75+(x**3)*0.0000004)
			desired_turf_height_min = 0.11
			desired_turf_height_max = 1
			desired_generation_type = /turf/generation/snow

		var/turf/old_turf = locate(x,y,z)
		desired_generation_type = new desired_generation_type(old_turf)
		desired_generation_type.height = isnum(desired_turf_height) ? desired_turf_height : clamp(noise_profile,desired_turf_height_min,desired_turf_height_max)

	log_subsystem(name,"Finished generating world [z].")
*/