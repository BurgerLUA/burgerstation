// WIP PvP: https://www.desmos.com/calculator/a2kvmtgx80

/turf/unsimulated/generation/snow
	name = "snow generation"
	icon_state = "snow"

/turf/unsimulated/generation/snow/generate(var/size = WORLD_SIZE)

	if(density && is_different && is_next_to_null_areas && is_next_to_dense_turfs && is_next_to_organic_turfs)
		new /turf/simulated/wall/rock/snow(src)
		if(prob(0.25))
			new /obj/marker/generation/turf/snow_wall(src)
		if(src.loc.type == /area/) new /area/mission/snow(src)
		disallow_generation = TRUE
		return ..()

	switch(noise) //Lower values means deeper.
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			new /turf/simulated/floor/ice(src)
			if(density)
				if(prob(1))
					new /obj/marker/generation/turf/snow_wall/small(src)
				if(prob(0.25))
					new /obj/marker/generation/mob/penguin(src)
				else if(prob(0.25))
					new /obj/marker/generation/mob/slime/ice(src)
			else
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			if(density)
				new /turf/simulated/liquid/water/river/ice(src)
				if(prob(1))
					new /obj/marker/generation/turf/ice(src)
					if(prob(0.25))
						new /obj/marker/generation/mob/slime/ice(src)
			else
				new /turf/simulated/floor/ice(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID)
			new /turf/simulated/floor/colored/snow(src)
			if(density)
				if(prob(1))
					new /obj/marker/generation/turf/snow_dirt(src)
					if(prob(0.25))
						new /obj/marker/generation/turf/snow_wall(src)
						if(prob(1))
							new /obj/marker/generation/mob/bear/snow(src)
				else if(prob(1))
					new /obj/marker/generation/foliage/bushes/snow(src)
				else if(prob(4))
					new /obj/marker/generation/foliage/grass/snow(src)
					if(prob(1))
						new /obj/marker/generation/mob/mouse/white(src)
				else if(prob(1))
					new /obj/marker/generation/foliage/tree/snow(src)
					if(prob(1))
						new /obj/marker/generation/turf/snow_dirt(src)
					if(prob(1))
						new /obj/marker/generation/mob/rev(src)
				else if(prob(1))
					new /obj/marker/generation/mob/snow_legion(src)
			else
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/colored/snow(src)
			if(density)
				if(prob(1))
					new /obj/marker/generation/foliage/tree/snow(src)
					if(prob(1))
						new /obj/marker/generation/turf/snow_dirt(src)
					if(prob(1))
						new /obj/marker/generation/mob/rev(src)
			else
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			new /turf/simulated/floor/colored/snow(src)
			if(density)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/snow(src)
				else if(prob(0.25))
					new /obj/marker/generation/turf/snow_wall(src)
					if(prob(1))
						new /obj/marker/generation/mob/bear/snow(src)
				else if(prob(1))
					new /obj/marker/generation/turf/snow_dirt(src)
			else
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(density)
				new /turf/simulated/wall/rock/snow(src)
				if(prob(2))
					new /obj/marker/generation/turf/snow_wall(src)
				else if(prob(1))
					new /obj/marker/generation/mob/legion/snow(src)
					new /obj/marker/generation/turf/snow(src)
			else
				new /turf/simulated/floor/colored/dirt/snow(src)
				disallow_generation = TRUE

	if(src.loc.type == /area/) new/area/mission/snow(src)

	return ..()

/turf/unsimulated/generation/snow/path
	icon_state = "snow_path"


/turf/unsimulated/generation/snow/path/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/snow(src)
		if(src.loc.type == /area/) new /area/mission/snow(src)
		disallow_generation = TRUE
		return ..()

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.1)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.1 to 0.4)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(4))
				new /obj/marker/generation/foliage/grass/snow(src)
			else if(prob(2))
				new /obj/marker/generation/plant/oxygen_fruit(src)
		if(0.4 to 0.41)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.41 to 0.43)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.43 to 0.44)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.44 to 0.94)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(1))
				new /obj/marker/generation/plant/nitrogen_flower(src)
			else if(prob(6))
				new /obj/marker/generation/foliage/grass/snow(src)
			else if(prob(0.2))
				new /obj/marker/generation/mob/bear/snow(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.95 to INFINITY)
			new /turf/simulated/floor/cave_dirt(src)

	if(src.loc.type == /area/) new /area/mission/snow(src)

	disallow_generation = TRUE

	if(prob(0.5))
		new /obj/marker/generation/mob/rev(src)

	return ..()