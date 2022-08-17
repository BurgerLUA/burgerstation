/turf/unsimulated/generation/ocean
	name = "ocean generation"
	icon_state = "ocean"

/turf/unsimulated/generation/ocean/path
	icon_state = "ocean_path"
	density = FALSE

/turf/unsimulated/generation/ocean/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/sand/beach(src)
		if(src.loc.type == /area/) new /area/mission/beach(src)
		disallow_generation = TRUE
		return ..()

	new /turf/simulated/liquid/water/sea(src) //Not sure what the noise profile should be so its this for now.

	if(src.loc.type == /area/)
		new /area/mission/ocean(src)

	. = ..()