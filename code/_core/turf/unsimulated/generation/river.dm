/turf/unsimulated/generation/river
	name = "river generation"
	icon_state = "river"

/turf/unsimulated/generation/river/path
	icon_state = "river_path"
	density = FALSE

/turf/unsimulated/generation/river/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/dirt(src)
		if(src.loc.type == /area/) new /area/mission/river(src)
		disallow_generation = TRUE
		return ..()

	new /turf/simulated/liquid/water/river(src) //Not sure what the noise profile should be so its this for now.

	if(src.loc.type == /area/)
		new /area/mission/river(src)

	. = ..()