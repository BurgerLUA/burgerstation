/turf/unsimulated/generation/forest
	name = "forest generation"
	icon_state = "forest"

/turf/unsimulated/generation/forest/path/
	icon_state = "forest_path"
	density = FALSE

/turf/unsimulated/generation/forest/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/dirt/path(src)
		if(src.loc.type == /area/) new /area/mission/forest(src)
		disallow_generation = TRUE
		return ..()

	if(!is_next_to_interior && is_different && !is_next_to_dense_turf)
		new /turf/simulated/wall/rock(src)
		if(src.loc.type == /area/) new /area/mission/forest(src)
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
			new /turf/simulated/liquid/water/river(src)
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			new /turf/simulated/floor/colored/dirt(src)
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID) //Low, place grass.
			new /turf/simulated/floor/colored/grass(src)
			if(prob(1))
				new /obj/marker/generation/foliage/grass(src)
				if(prob(1))
					new /obj/marker/generation/mob/cow(src)
			else if(prob(1))
				if(prob(1))
					new /obj/marker/generation/plant/wheat(src)
					if(prob(1))
						new /obj/marker/generation/mob/chicken/brown(src)
				else
					new /obj/marker/generation/foliage/flowers/lavender(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/bushes/grass(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/bushes/pointy(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/bushes/stick(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/bushes/sun(src)
			else if(prob(1))
				new /obj/marker/generation/forest_soil(src)
				new /obj/marker/generation/plant/tomato(src)
				if(prob(0.25))
					new /obj/marker/generation/mob/goblin(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/tree(src)
				if(prob(1))
					new /obj/marker/generation/mob/chicken/black(src)
			else if(prob(5))
				new /obj/marker/generation/foliage/grass(src)
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH) //High, place trees.
			new /turf/simulated/floor/colored/grass(src)
			if(prob(2))
				new /obj/marker/generation/foliage/tree(src)
				if(prob(1))
					new /obj/marker/generation/plant/chanterelle(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/flowers(src)
				if(prob(1))
					new /obj/marker/generation/mob/bee(src)
			else if(prob(1))
				if(prob(75))
					new /obj/marker/generation/forest_dirt(src)
				else
					new /obj/marker/generation/forest_soil(src)
				if(prob(1))
					new /obj/marker/generation/plant/cabbage(src)
					if(prob(1))
						new /obj/marker/generation/mob/goat(src)
			else if(prob(5))
				new /obj/marker/generation/foliage/grass(src)
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/floor/colored/dirt(src)
			if(prob(1))
				new /obj/marker/generation/rock_wall(src)
			else if(prob(0.25))
				new /obj/marker/generation/water(src)
			else
				if(prob(1))
					new /obj/marker/generation/plant/fly_amanita(src)
				if(prob(1))
					new /obj/marker/generation/mob/bear/black(src)
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			new /turf/simulated/wall/rock/moss(src)
			if(prob(1))
				new /obj/marker/generation/rock_wall(src)

	if(src.loc.type == /area/) new /area/mission/forest(src)

	return ..()