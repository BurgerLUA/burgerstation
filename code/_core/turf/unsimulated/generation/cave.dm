/turf/unsimulated/generation/forest_cave
	name = "cave generation"
	icon_state = "caves"

/turf/unsimulated/generation/forest_cave/path
	icon_state = "caves_path"
	density = FALSE

/turf/unsimulated/generation/forest_cave/generate(var/size = WORLD_SIZE)

	if(x <= VIEW_RANGE*2 || x >= size - VIEW_RANGE*2 || y <= VIEW_RANGE*2 || y >= size - VIEW_RANGE*2) //Handle edges.
		new /turf/simulated/wall/rock(src)
		if(prob(5))
			new /obj/marker/generation/rock_wall(src)
		else
			new /obj/marker/generation/rock_wall/small(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
		return ..()

	if(!density)
		if(is_different)
			if(prob(1))
				new /obj/marker/generation/cave_dirt(src)
			else if(prob(2))
				new /obj/marker/generation/rock_wall(src)
		new /turf/simulated/floor/colored/dirt/cave(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
		disallow_generation = TRUE
		return ..()

	if(is_different && is_next_to_null_area)
		new /turf/simulated/wall/rock(src)
		if(prob(1))
			new /obj/marker/generation/rock_wall(src)
		else
			new /obj/marker/generation/rock_wall/small(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
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

	noise += (y/size)*0.5 //Force walls at the top.

	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			new /turf/simulated/liquid/water/cave(src)
			if(prob(1))
				new /obj/marker/generation/mob/carp(src)
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(1))
				new /obj/marker/generation/mob/bear/brown(src)
			else if(prob(1))
				new /obj/marker/generation/mob/bat(src)
			else if(prob(0.5))
				new /obj/marker/generation/mob/mouse/grey(src)
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(1))
				new /obj/marker/generation/mob/cave_spider(src)
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(0.5))
				new /obj/marker/generation/rock_wall(src)
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/wall/rock(src)
			if(prob(1))
				new /obj/marker/generation/rock_wall(src)
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			new /turf/simulated/wall/rock(src)
			if(prob(1))
				new /obj/marker/generation/rock_wall(src)

	if(src.loc.type == /area/)
		new /area/mission/caves(src)

	. = ..()