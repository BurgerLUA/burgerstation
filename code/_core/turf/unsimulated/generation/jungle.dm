/turf/unsimulated/generation/jungle
	name = "jungle generation"
	icon_state = "jungle"

/turf/unsimulated/generation/jungle/path
	icon_state = "jungle_path"
	density = FALSE

/turf/unsimulated/generation/jungle/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/dirt/jungle(src)
		if(src.loc.type == /area/) new /area/mission/jungle(src)
		disallow_generation = TRUE
		if(prob(1))
			new /obj/marker/generation/foliage/jungle_light/stick(src)
		if(prob(2))
			new /obj/marker/generation/jungle_dirt(src)
		return ..()

	if(is_different)
		if(is_next_to_dense_turf && !is_next_to_interior && prob(90))
			new /turf/simulated/wall/rock/brown(src)
			if(prob(1))
				new /obj/marker/generation/jungle_wall(src)
		else
			new /turf/simulated/floor/cave_dirt(src)
		if(src.loc.type == /area/) new /area/mission/jungle(src)
		disallow_generation = TRUE
		return ..()

	if(src.loc.type == /area/) new /area/mission/jungle(src)
	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST*0.5)
			new /turf/simulated/liquid/water/river/jungle(src)
			disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOWEST*0.5 to GENERATION_SEGMENT_LOWEST)
			new /turf/simulated/liquid/water/river/jungle(src)
			if(prob(1))
				new /obj/marker/generation/mob/carp(src)
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(0.5))
				new /obj/marker/generation/water/jungle(src)
			else if(prob(1))
				new /obj/marker/generation/jungle_dirt(src)
				if(prob(80))
					new /obj/marker/generation/foliage/grass/jungle/rock(src)
					if(prob(1))
						new /obj/marker/generation/mob/lizard(src)
				else
					new /obj/marker/generation/plant/destroying_angel(src)
			else if(prob(0.25))
				new /obj/marker/generation/foliage/tree/jungle/small(src)
			else if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle(src)
				if(prob(1))
					new /obj/marker/generation/mob/venus_human_trap(src)
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(1))
				new /obj/marker/generation/foliage/tree/jungle/small(src)
			else if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle(src)
				if(prob(1))
					if(prob(25))
						new /obj/marker/generation/mob/slime/jungle(src)
					else
						new /obj/marker/generation/mob/monkey(src)
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(1))
				new /obj/marker/generation/foliage/tree/jungle(src)
			else if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle(src)
				if(prob(1))
					new /obj/marker/generation/mob/venus_human_trap(src)
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/wall/rock/basalt(src)
			if(prob(1))
				new /obj/marker/generation/basalt(src)
				new /obj/marker/generation/mob/arachnid(src)
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			new /turf/simulated/liquid/lava(src)

	return ..()