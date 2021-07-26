/turf/unsimulated/generation
	icon = 'icons/turf/generation.dmi'
	var/is_different = FALSE
	var/no_wall = FALSE

/turf/unsimulated/generation/proc/pre_generate()

	for(var/k in list(NORTH,EAST,SOUTH,WEST))
		var/turf/T = get_step(src,k)
		if(T && !istype(T,src))
			is_different = TRUE
			break

	return TRUE

/turf/unsimulated/generation/proc/generate(var/size = WORLD_SIZE)
	return TRUE

/turf/unsimulated/virtual_reality
	name = "virtual reality"

	icon = 'icons/turf/floor/circuit.dmi'
	icon_state = "gcircuit"

/turf/unsimulated/generation/surface/
	icon = 'icons/turf/generation.dmi'

/turf/unsimulated/generation/surface/surface_turf
	icon_state = "surface_turf"

/turf/unsimulated/generation/surface/cave_turf
	icon_state = "cave_turf"

/turf/unsimulated/generation/surface/surface_path_turf
	icon_state = "surface_path_turf"

/turf/unsimulated/generation/surface/cave_path_turf
	icon_state = "cave_path_turf"

