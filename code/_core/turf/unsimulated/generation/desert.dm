/turf/unsimulated/generation/desert
	name = "desert generation"
	icon_state = "desert"

/turf/unsimulated/generation/desert/path
	icon_state = "desert_path"
	density = FALSE

/turf/unsimulated/generation/desert/generate(var/size = WORLD_SIZE)

	if(density && is_different && is_next_to_null_areas && is_next_to_dense_turfs && is_next_to_organic_turfs)
		new /turf/simulated/wall/rock/desert(src)
		if(src.loc.type == /area/) new /area/mission/desert/interior(src)
		disallow_generation = TRUE
		return ..()

	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOW - 0.1)
			if(!density)
				new /turf/simulated/floor/colored/sand/desert/lighter(src)
				disallow_generation = TRUE
			else if(prob(2))
				new /turf/simulated/liquid/water/desert(src)
				new /obj/marker/generation/turf/water/desert(src)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/water(src)
			else
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/sand(src)
				else if(prob(1))
					new /obj/marker/generation/mob/zombie/desert(src)
				new /turf/simulated/floor/colored/sand/desert/lighter(src)
		if(GENERATION_SEGMENT_LOW - 0.1 to GENERATION_SEGMENT_LOW)
			if(!density)
				new /turf/simulated/floor/colored/sand/desert/lighter(src)
				disallow_generation = TRUE
			else
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/sand(src)
				else if(prob(1))
					new /obj/marker/generation/mob/zombie/desert(src)
				new /turf/simulated/floor/colored/sand/desert/lighter(src)
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_LOW + 0.1)
			if(!density)
				new /turf/simulated/floor/colored/sand/desert/lighter(src)
				disallow_generation = TRUE
			else
				if(prob(1))
					new /obj/marker/generation/mob/slime/sand(src)
				else if(prob(1))
					new /obj/marker/generation/mob/zombie/desert(src)
				new /turf/simulated/floor/colored/sand/desert/lighter(src)
		if(GENERATION_SEGMENT_LOW + 0.1 to GENERATION_SEGMENT_MID)
			if(!density)
				new /turf/simulated/floor/colored/sand/desert(src)
				disallow_generation = TRUE
			else
				if(prob(2))
					new /obj/marker/generation/plant/cactus_fruit(src)
				if(prob(1))
					new /obj/marker/generation/mob/slime/sand(src)
				new /turf/simulated/floor/colored/sand/desert(src)
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			if(!density)
				new /turf/simulated/floor/colored/sand/desert(src)
				disallow_generation = TRUE
			else
				if(prob(0.5))
					new /obj/marker/generation/turf/desert_wall(src)
				else if(prob(2))
					new /obj/marker/generation/plant/cactus_fruit(src)
				new /turf/simulated/floor/colored/sand/desert(src)

		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			if(!density)
				new /turf/simulated/floor/cave_dirt(src)
				disallow_generation = TRUE
			else
				if(prob(5))
					new /obj/marker/generation/plant/glowshroom(src)
					if(prob(3))
						new /obj/marker/generation/mob/spider/glow(src)
				new /turf/simulated/floor/cave_dirt(src)

		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(!density)
				new /turf/simulated/floor/cave_dirt(src)
			else
				new /turf/simulated/wall/rock/desert(src)
				disallow_generation = TRUE

	if(src.loc.type == /area/)
		if(src.density || src.type == /turf/simulated/floor/cave_dirt)
			new /area/mission/desert/interior(src)
		else
			new /area/mission/desert(src)


	. = ..()