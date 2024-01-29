

/*
	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)

		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)

		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID)

		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)

		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)

		if(GENERATION_SEGMENT_HIGHEST to INFINITY)

*/



/turf/unsimulated/generation
	icon = 'icons/turf/generation.dmi'
	var/is_different = FALSE
	var/is_next_to_interior = FALSE
	var/is_next_to_null_area = FALSE
	var/is_next_to_dense_turf = FALSE
	var/is_next_to_simulated = FALSE
	density = TRUE

	var/noise = 0

	var/noise_num_offset = 1


/turf/unsimulated/generation/proc/pre_generate()

	var/x_seed = x / world.maxx
	var/y_seed = y / world.maxy

	var/max_instances = NOISE_INSTANCES
	var/maximum_value = 0
	var/minimum_value = 1
	for(var/i=1,i<=max_instances,i++)
		var/noise_value = text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[noise_num_offset+z+i]]","[x_seed]","[y_seed]"))
		var/distance_mod = max(abs(0.5 - x_seed) + abs(0.5 - y_seed))
		var/tweaked_noise_value = 0.5 + sin(noise_value*NOISE_CURVES*180)*0.5 + (0.5 - distance_mod)
		maximum_value = max(maximum_value,tweaked_noise_value)
		minimum_value = min(minimum_value,tweaked_noise_value)
		noise += tweaked_noise_value

	noise *= 1/max_instances
	noise = (noise + maximum_value + minimum_value + 0.5) / 4

	for(var/k in SSturf.turf_check_directions)
		var/turf/T = get_step(src,k)
		if(!T)
			continue
		if(src.type != T.type && src.parent_type != T.type && src.type != T.parent_type)
			is_different = TRUE
		else
			continue
		if(T.density)
			is_next_to_dense_turf = TRUE
		if(is_simulated(T))
			is_next_to_simulated = TRUE
		var/area/A = T.loc
		if(A.interior)
			is_next_to_interior = TRUE
		if(A.type == /area/)
			is_next_to_null_area = TRUE


	return TRUE

/turf/unsimulated/generation/proc/generate(size = WORLD_SIZE)
	return TRUE

/*
/turf/unsimulated/virtual_reality
	name = "virtual reality"

	icon = 'icons/turf/floor/circuit.dmi'
	icon_state = "gcircuit"

/turf/unsimulated/generation/surface/
	icon = 'icons/turf/generation.dmi'

/turf/unsimulated/generation/surface/surface_turf
	icon_state = "surface_turf"

/turf/unsimulated/generation/surface/surface_path_turf
	icon_state = "surface_path_turf"

/turf/unsimulated/generation/surface/cave_turf
	icon_state = "cave_turf"

/turf/unsimulated/generation/surface/cave_path_turf
	icon_state = "cave_path_turf"

/turf/unsimulated/generation/surface/snow_turf
	icon_state = "snow_turf"

/turf/unsimulated/generation/surface/snow_path_turf
	icon_state = "snow_path_turf"
*/


