/turf/unsimulated/generation/forest_cave
	name = "cave generation"
	icon_state = "caves"

	noise_num_offset = 2

/turf/unsimulated/generation/forest_cave/path
	icon_state = "caves_path"
	density = FALSE

/turf/unsimulated/generation/forest_cave/generate(var/size = WORLD_SIZE)

	if(density && (x <= VIEW_RANGE || x >= size - VIEW_RANGE || y <= VIEW_RANGE || y >= size - VIEW_RANGE)) //Handle edges.
		new /turf/simulated/wall/rock(src)
		if(prob(5))
			new /obj/marker/generation/turf/rock_wall(src)
		else
			new /obj/marker/generation/turf/rock_wall/small(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
		disallow_generation = TRUE
		return ..()

	if(!density) //path subtype.
		if(is_different)
			if(prob(1))
				new /obj/marker/generation/turf/cave_dirt(src)
			else if(prob(2))
				new /obj/marker/generation/turf/rock_wall(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
		new /turf/simulated/floor/colored/dirt/cave(src)
		disallow_generation = TRUE
		return ..()

	if(is_different && is_next_to_null_area && is_next_to_dense_turf && !is_next_to_simulated)
		if(prob(1))
			new /obj/marker/generation/turf/rock_wall(src)
		else
			new /obj/marker/generation/turf/rock_wall/small(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
		new /turf/simulated/wall/rock(src)
		disallow_generation = TRUE
		return ..()

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
				new /obj/marker/generation/mob/spider(src)
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(0.25))
				new /obj/marker/generation/mob/slime/cave(src)
			else if(prob(0.5))
				new /obj/marker/generation/turf/rock_wall(src)
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/wall/rock(src)
			if(prob(1))
				new /obj/marker/generation/turf/rock_wall(src)
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			new /turf/simulated/wall/rock(src)
			if(prob(1))
				new /obj/marker/generation/turf/rock_wall(src)

	if(prob(0.5))
		if(src.density)
			new /obj/marker/generation/ore/wall(src)
		else
			new /obj/marker/generation/ore/floor(src)

	if(src.loc.type == /area/)
		new /area/mission/caves(src)

	. = ..()