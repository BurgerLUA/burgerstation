var/global/list/turf_check_directions = list(NORTH,EAST,SOUTH,WEST)

/turf/unsimulated/generation
	icon = 'icons/turf/generation.dmi'
	var/is_different = FALSE
	var/is_next_to_interior = FALSE
	var/is_next_to_null_area = FALSE
	var/is_next_to_dense_turf = FALSE
	density = TRUE


/turf/unsimulated/generation/proc/pre_generate()

	for(var/k in turf_check_directions)
		var/turf/T = get_step(src,k)
		if(!T)
			is_next_to_null_area = TRUE
			is_different = TRUE
			is_next_to_interior = TRUE
			break
		var/area/A = T.loc
		if(T.density)
			is_next_to_dense_turf = TRUE
		if(T.parent_type != src.type && T.type != src.parent_type)
			is_different = TRUE
		if(A.interior)
			is_next_to_interior = TRUE
		if(A.type == /area/)
			is_next_to_null_area = TRUE


	return TRUE

/turf/unsimulated/generation/proc/generate(var/size = WORLD_SIZE)
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


