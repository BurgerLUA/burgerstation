/turf/unsimulated/generation/forest
	name = "forest generation"
	icon_state = "forest"

/turf/unsimulated/generation/forest/path/
	icon_state = "forest_path"
	density = FALSE


//https://www.desmos.com/calculator/u1xlukfjrf
var/global/snow_line = rand(330,410)
var/global/snow_num = 0.6+rand()*0.2

/turf/unsimulated/generation/forest/generate(var/size = WORLD_SIZE)

	var/is_snow = y >= snow_line - (x*0.05)**(snow_num*2) + sin(x)*10

	if(is_snow)

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
					else if(prob(5))
						new /obj/marker/generation/mob/penguin(src)
					else if(prob(1))
						new /obj/marker/generation/mob/slime/ice(src)
				else
					disallow_generation = TRUE
			if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
				if(density)
					new /turf/simulated/liquid/water/river/ice(src)
					if(prob(1))
						new /obj/marker/generation/turf/ice(src)
						if(prob(5))
							new /obj/marker/generation/mob/penguin(src)
						if(prob(1))
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

		if(src.loc.type == /area/) new /area/mission/snow(src)

	else


		if(density && is_different && is_next_to_null_areas && is_next_to_dense_turfs && is_next_to_organic_turfs)
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
						new /obj/marker/generation/turf/water(src)
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
						new /obj/marker/generation/turf/forest_soil(src)
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
							new /obj/marker/generation/turf/forest_dirt(src)
						else
							new /obj/marker/generation/turf/forest_soil(src)
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
					if(prob(20))
						new /obj/marker/generation/turf/rock_wall(src)
					else if(prob(0.25))
						new /obj/marker/generation/turf/water(src)
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
					if(prob(5))
						new /obj/marker/generation/turf/rock_wall(src)
				else
					new /turf/simulated/floor/cave_dirt(src)
					disallow_generation = TRUE

		if(src.loc.type == /area/) new /area/mission/forest(src)

	return ..()