/turf/unsimulated/generation/desert
	name = "desert generation"
	icon_state = "desert"

/turf/unsimulated/generation/desert/path
	icon_state = "desert_path"
	density = FALSE

/turf/unsimulated/generation/desert/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/sand/desert(src)
		if(src.loc.type == /area/) new /area/mission/desert(src)
		disallow_generation = TRUE
		return ..()

	if(!is_next_to_interior && is_different && !is_next_to_dense_turf)
		new /turf/simulated/wall/rock/desert(src)
		if(src.loc.type == /area/) new /area/mission/desert/interior(src)
		disallow_generation = TRUE
		return ..()

	var/x_seed = x / size
	var/y_seed = y / size

	var/max_instances = NOISE_INSTANCES
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances
	if(NOISE_CURVES) noise = 0.5 + sin((noise+0.5)*NOISE_CURVES*180)*0.5


	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			if(prob(0.5))
				new /turf/simulated/liquid/water/desert(src)
				new /obj/marker/generation/water/desert(src)
			else
				new /turf/simulated/floor/grass(src)
				new /obj/structure/scenery/grass/jungle(src)
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			new /turf/simulated/floor/grass(src)
			new /obj/structure/scenery/grass/jungle(src)
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_LOW + 0.1)
			new /turf/simulated/floor/colored/sand/oasis(src)
		if(GENERATION_SEGMENT_LOW + 0.1 to GENERATION_SEGMENT_MID)
			new /turf/simulated/floor/colored/sand/desert(src)
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/colored/sand/desert(src)
			if(prob(0.5))
				new /obj/marker/generation/desert_wall(src)
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/floor/cave_dirt(src)
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			new /turf/simulated/wall/rock/desert(src)

	if(src.loc.type == /area/)
		if(!src.density)
			new /area/mission/desert(src)
		else
			new /area/mission/desert/interior(src)

	. = ..()