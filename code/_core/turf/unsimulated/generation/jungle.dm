/turf/unsimulated/generation/jungle
	name = "jungle generation"
	icon_state = "jungle"

	noise_num_offset = 5

/turf/unsimulated/generation/jungle/path
	icon_state = "jungle_path"
	density = FALSE

/turf/unsimulated/generation/jungle/generate(var/size = WORLD_SIZE)

	if(!density)
		if(noise >= GENERATION_SEGMENT_HIGH && noise <= GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/floor/boss(src)
		else if(noise <= 0.25)
			if(is_different && prob(40))
				new/obj/structure/scenery/rocks(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		else
			if(prob(2))
				new/obj/structure/scenery/grass/jungle(src)
			else if(prob(1))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
			if(prob(1))
				new/obj/marker/generation/mob/slime/jungle(src)
			new /turf/simulated/floor/grass/jungle(src)


		if(src.loc.type == /area/) new /area/mission/jungle(src)
		disallow_generation = TRUE
		if(prob(3))
			new /obj/marker/generation/foliage/jungle_light/stick(src)
		if(prob(2))
			new /obj/marker/generation/turf/jungle_dirt(src)
		return ..()

	if(is_different)
		if(is_next_to_null_area && is_next_to_dense_turf && !is_next_to_simulated && prob(90))
			new /turf/simulated/wall/rock/moss(src)
			if(prob(1))
				new /obj/marker/generation/turf/jungle_wall(src)
		else
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(1))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
		if(src.loc.type == /area/) new /area/mission/jungle(src)
		disallow_generation = TRUE
		return ..()

	if(noise >= GENERATION_SEGMENT_LOW && noise <= GENERATION_SEGMENT_HIGH && src.loc.type == /area/ && prob(5))
		var/valid_placement = TRUE
		for(var/k in all_rituals)
			var/obj/structure/interactive/ritual/R = k
			if(get_dist(src,R) <= VIEW_RANGE*4)
				valid_placement = FALSE
				break
		if(valid_placement)
			new /obj/marker/generation/turf/jungle_dirt(src)
			new /obj/structure/interactive/ritual(src)
			new /obj/marker/smart_clear_turf(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
			disallow_generation = TRUE
			if(src.loc.type == /area/) new /area/mission/jungle(src)
			return ..()

	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			new /turf/simulated/liquid/water/river/jungle(src)
			if(prob(1))
				new /obj/marker/generation/mob/carp/jungle(src)
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(0.5))
				new /obj/marker/generation/turf/water/jungle(src)
			else if(prob(1))
				new /obj/marker/generation/turf/jungle_dirt(src)
				if(prob(80))
					new /obj/marker/generation/foliage/grass/jungle/rock(src)
					if(prob(1))
						new /obj/marker/generation/mob/lizard(src)
				else
					new /obj/marker/generation/plant/destroying_angel(src)
			else if(prob(5))
				new /obj/marker/generation/foliage/tree/jungle/small(src)
				if(prob(1))
					new /obj/marker/generation/mob/monkey(src)
					new /obj/marker/generation/foliage/bushes/stick(src)
			else if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle(src)
				if(prob(1))
					new /obj/marker/generation/mob/venus_human_trap(src)
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(2))
				new /obj/marker/generation/foliage/bushes/fern(src)
			else if(prob(5))
				new /obj/marker/generation/foliage/tree/jungle/small(src)
				if(prob(1))
					new /obj/marker/generation/mob/monkey(src)
					new /obj/marker/generation/foliage/bushes/stick(src)
			else if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle(src)
				if(prob(1))
					new /obj/marker/generation/mob/slime/jungle(src)
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(15))
				new /obj/marker/generation/foliage/tree/jungle(src)
				if(prob(1))
					new /obj/marker/generation/mob/monkey(src)
					new /obj/marker/generation/foliage/bushes/stick(src)
				else if(prob(1))
					new /obj/marker/generation/mob/arachnid(src)
					new /obj/marker/generation/foliage/bushes/pale(src)
			else if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle(src)
				if(prob(10))
					new /obj/marker/generation/mob/venus_human_trap(src)
			else if(prob(20))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			if(rand_map(src,20))
				new /turf/simulated/liquid/lava(src)
				if(prob(2))
					new/obj/marker/generation/turf/basalt/island(src)
					new/obj/marker/generation/mob/slime/magma(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/glowcap(src)
				if(prob(1))
					new/obj/marker/generation/turf/basalt(src)
				if(prob(1))
					new/obj/marker/generation/mob/slime/basalt(src)
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/foliage/tree/jungle(src)
			else if(prob(1))
				new /obj/marker/generation/mob/arachnid(src)
				new /obj/marker/generation/foliage/bushes/pale(src)
			else if(prob(10))
				new /obj/marker/generation/foliage/tree/jungle/small(src)
			if(prob(10))
				new /obj/marker/generation/foliage/grass/jungle/rock(src)


	if(prob(0.5))
		if(src.density)
			new /obj/marker/generation/ore/wall(src)
		else
			new /obj/marker/generation/ore/floor(src)

	if(src.loc.type == /area/) new /area/mission/jungle(src)

	return ..()


/turf/unsimulated/generation/jungle/pre_generate()
	. = ..()
	noise += y/world.maxy
	noise = MODULUS(noise,1)