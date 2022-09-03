/turf/unsimulated/generation/forest
	name = "forest generation"
	icon_state = "forest"

/turf/unsimulated/generation/forest/path/
	icon_state = "forest_path"
	density = FALSE

/turf/unsimulated/generation/forest/generate(var/size = WORLD_SIZE)

	if(density && !is_next_to_interior && is_different && !is_next_to_dense_turf)
		new /turf/simulated/wall/rock(src)
		if(src.loc.type == /area/) new /area/mission/forest(src)
		disallow_generation = TRUE
		return ..()

	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			if(!density)
				new /turf/simulated/floor/colored/dirt(src)
				disallow_generation = TRUE
			else
				new /turf/simulated/liquid/water/river(src)
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			new /turf/simulated/floor/colored/dirt(src)
			if(!density) disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID) //Low, place grass or ponds.
			if(density)
				new /turf/simulated/floor/colored/grass(src)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/water(src)
					new /obj/marker/generation/water(src)
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
			else
				new/turf/simulated/floor/colored/dirt/path(src)
				disallow_generation = TRUE

		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH) //High, place trees.
			if(density)
				new /turf/simulated/floor/colored/grass(src)
				if(prob(2))
					new /obj/marker/generation/foliage/tree(src)
					if(prob(1))
						new /obj/marker/generation/plant/chanterelle(src)
					if(prob(0.5))
						new /obj/marker/generation/mob/slime/forest(src)
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
			else
				new/turf/simulated/floor/colored/dirt/path(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/floor/colored/dirt(src)
			if(density)
				if(prob(1))
					new /obj/marker/generation/rock_wall(src)
				else if(prob(0.25))
					new /obj/marker/generation/water(src)
				else
					if(prob(1))
						new /obj/marker/generation/plant/fly_amanita(src)
					if(prob(1))
						new /obj/marker/generation/mob/bear/black(src)
			else
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(density)
				new /turf/simulated/wall/rock/moss(src)
				if(prob(1))
					new /obj/marker/generation/rock_wall(src)
			else
				new /turf/simulated/floor/cave_dirt(src)
				disallow_generation = TRUE

	if(src.loc.type == /area/) new /area/mission/forest(src)

	return ..()