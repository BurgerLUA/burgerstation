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

	var/x_seed = x / size
	var/y_seed = y / size

	var/max_instances = 1
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances
	if(NOISE_CURVES) noise = 0.5 + sin((noise+0.5)*NOISE_CURVES*180)*0.5



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
					new /obj/marker/generation/mob/venus_human_trap(src)
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