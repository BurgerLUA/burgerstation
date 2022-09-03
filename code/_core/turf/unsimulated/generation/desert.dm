/turf/unsimulated/generation/desert
	name = "desert generation"
	icon_state = "desert"

/turf/unsimulated/generation/desert/path
	icon_state = "desert_path"
	density = FALSE

/turf/unsimulated/generation/desert/generate(var/size = WORLD_SIZE)

	if(density && !is_next_to_interior && is_different && !is_next_to_dense_turf)
		new /turf/simulated/wall/rock/desert(src)
		if(src.loc.type == /area/) new /area/mission/desert/interior(src)
		disallow_generation = TRUE
		return ..()

	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOW - 0.1)
			if(!density)
				new /turf/simulated/floor/grass(src)
				disallow_generation = TRUE
			else if(prob(0.5))
				new /turf/simulated/liquid/water/desert(src)
				new /obj/marker/generation/water/desert(src)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/water(src)
			else
				new /turf/simulated/floor/grass(src)
				new /obj/structure/scenery/grass/jungle(src)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/sand(src)
		if(GENERATION_SEGMENT_LOW - 0.1 to GENERATION_SEGMENT_LOW)
			new /turf/simulated/floor/grass(src)
			if(density)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/sand(src)
			else
				new /obj/structure/scenery/grass/jungle(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_LOW + 0.1)
			new /turf/simulated/floor/colored/sand/oasis(src)
			if(!density)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOW + 0.1 to GENERATION_SEGMENT_MID)
			new /turf/simulated/floor/colored/sand/desert(src)
			if(!density)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/colored/sand/desert(src)
			if(!density)
				disallow_generation = TRUE
			else if(prob(0.5))
				new /obj/marker/generation/desert_wall(src)
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/floor/cave_dirt(src)
			if(!density)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(density)
				new /turf/simulated/wall/rock/desert(src)
			else
				new /turf/simulated/floor/cave_dirt(src)
				disallow_generation = TRUE

	if(src.loc.type == /area/)
		if(!src.density)
			new /area/mission/desert(src)
		else
			new /area/mission/desert/interior(src)

	. = ..()