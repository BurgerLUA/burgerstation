/turf/generation
	name = "generation turf"
	var/height = 0
	var/allow_wall = TRUE

/turf/generation/proc/pre_generate()
	return TRUE

/turf/generation/proc/generate()
	return TRUE

/turf/generation/forest

/turf/generation/forest/generate()

	switch(height)
		if(HEIGHT_WATER_MIN to HEIGHT_WATER_MAX)
			var/old_height = src.height
			var/turf/simulated/liquid/water/pond/P = new(src)
			P.depth = 4 + (1 - old_height/HEIGHT_WATER_MAX)*10
		if(HEIGHT_FLOOR_MIN to HEIGHT_FLOOR_MAX*0.05) //Lowest of floors.
			new /turf/simulated/floor/cave_dirt(src)
		if(HEIGHT_FLOOR_MAX*0.05 to HEIGHT_FLOOR_MAX*0.2)
			new /turf/simulated/floor/colored/dirt(src)
		if(HEIGHT_FLOOR_MAX*0.2 to HEIGHT_FLOOR_MAX)
			new /turf/simulated/floor/colored/grass(src)
		if(HEIGHT_FLOOR_MAX to HEIGHT_WALL_MAX*0.05)
			new /turf/simulated/wall/rock/moss(src)
		if(HEIGHT_FLOOR_MAX*0.05 to INFINITY)
			new /turf/simulated/wall/rock(src)

	new /area/generation(src)

	return TRUE

/turf/generation/ice


/turf/generation/snow


/turf/generation/ocean


/turf/generation/beach


/turf/generation/river
