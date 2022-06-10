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
		"generate",
		"maps/_core/station.dmm",
		"maps/_core/bluespace.dmm"
	)

/subsystem/dmm_suite/Initialize()

	dmm_suite = new()

	//Load all the maps.
	for(var/i=1,i<=length(maps_to_load),i++)
		var/k = maps_to_load[i]
		if(k == "generate")
			if(world.maxz < i)
				world.maxz = i
			generate_world(i)
		else
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

/subsystem/dmm_suite/proc/generate_world(var/z=0)

	if(z <= 0)
		CRASH("Bad Z level!")
		return FALSE

	//UNUSED Generation: https://www.desmos.com/calculator/hj1nskeotw

	//River Generation: https://www.desmos.com/calculator/wibgiygmfi
	var/river_skew = RAND_PRECISE(-0.3,0.3)
	var/river_x = rand(150,350)-river_skew*100
	var/river_down = rand(0,500) //Honestly doesn't matter.
	var/river_offset_1 = rand(80,100)
	var/river_offset_2 = rand(80,100)
	var/river_tension = RAND_PRECISE(3,5)*pick(-1,1)
	var/river_wiggle = RAND_PRECISE(3,5)*pick(-1,1)
	var/river_width = rand(10,20) //Width is actually double this.
	var/river_top_mod = RAND_PRECISE(-0.01 - river_width*0.001,0.2)
	#define RIVER_1 (x > river_x + sin((y-river_down)*river_tension - river_offset_1) * river_wiggle - river_width + (y*river_skew) - y*river_top_mod)
	#define RIVER_2 (x < river_x + sin((y-river_down)*river_tension + river_offset_2) * -river_wiggle + river_width + (y*river_skew) + y*river_top_mod)


	//Ocean and Beach Generation: https://www.desmos.com/calculator/wfpzji1e3v
	var/beach_bumps = RAND_PRECISE(3,6)
	var/beach_skew = RAND_PRECISE(-0.1,0.1)
	var/beach_line = rand(50+beach_skew*80,80)
	var/beach_wiggle = rand(12,30)-beach_bumps*2

	//Snow Generation: https://www.desmos.com/calculator/wpmqqu4yhj
	var/snow_strength = RAND_PRECISE(0.3,0.6)
	var/snow_offset = rand(500,700)
	var/snow_height = rand(200,400)*snow_strength

	for(var/x=1,x<=world.maxx,x++) for(var/y=1,y<=world.maxy,y++)

		var/turf/desired_turf

		if(x == 1 || x == world.maxx)
			desired_turf = /turf/simulated/wall/rock/indestructable
		else if(y == 1 || y == world.maxy)
			desired_turf = /turf/simulated/wall/rock/indestructable
		//Ocean generation
		else if(y < 150*abs(beach_skew) + beach_line + beach_wiggle*(1-abs(beach_skew*0.5))+(-beach_skew*250)-sin(x * beach_bumps*(360/500))*(beach_wiggle-beach_bumps)+x*beach_skew+(x**2)*0.0002-cos(x)*beach_wiggle*2)
			desired_turf = /turf/simulated/liquid/water/sea
		//River generation
		else if(RIVER_1 && RIVER_2)
			desired_turf = /turf/simulated/liquid/water/river
		//Beach generation
		else if(y < beach_line + 40 + abs(-beach_skew*300)-sin(x*beach_bumps*(360/500))*beach_wiggle + (x**2)*0.0002+cos(x+180)*beach_wiggle*2)
			desired_turf = /turf/simulated/floor/colored/sand/beach
		//Snow generation
		else if(y > world.maxy*snow_strength-sin( (x-snow_offset-snow_height)/(world.maxx*snow_strength*0.5))*world.maxx*(snow_strength**2)+snow_height+x*snow_strength)
			desired_turf = /turf/simulated/floor/colored/snow

		if(!desired_turf)
			desired_turf = /turf/simulated/floor/colored/grass

		var/turf/T = locate(x,y,z)
		desired_turf = new desired_turf(T)




