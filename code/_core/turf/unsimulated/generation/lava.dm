/turf/unsimulated/generation/lava
	name = "lava generation"
	icon_state = "lava"

	noise_num_offset = 6

/turf/unsimulated/generation/lava/path
	icon_state = "lava_path"
	density = FALSE

/turf/unsimulated/generation/lava/generate(var/size = WORLD_SIZE)

	var/range_times_noise = round(VIEW_RANGE*noise,1)

	if(density && (x <= range_times_noise || x >= size - range_times_noise || y <= range_times_noise || y >= size - range_times_noise)) //Handle edges.
		new /turf/simulated/wall/rock/basalt(src)
		if(prob(1))
			new/obj/marker/generation/turf/ash_wall(src)
		if(prob(1))
			new/obj/marker/generation/mob/goliath(src)
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	if(is_different)
		if(!density && is_next_to_null_area)
			if(prob(5))
				new/turf/simulated/wall/ash/volcanic(src)
				new/obj/marker/generation/turf/ash_wall(src)
				if(prob(5))
					new/obj/marker/generation/ore/wall(src)
			else if(prob(5))
				new /turf/simulated/floor/colored/ash/volcanic(src)
				new/obj/marker/generation/turf/ash_floor(src)
				if(prob(5))
					new/obj/marker/generation/ore/floor(src)
			else
				new /turf/simulated/floor/basalt(src)


		else if(is_next_to_null_area && is_next_to_dense_turf && !is_next_to_simulated)
			new /turf/simulated/wall/rock/basalt(src)
			if(prob(1))
				new/obj/marker/generation/turf/ash_wall(src)
			if(prob(1))
				new/obj/marker/generation/mob/goliath(src)
		else
			new /turf/simulated/floor/basalt(src)
			if(prob(0.5))
				new /obj/marker/generation/plant/glowcap(src)
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	switch(noise)
		//Basalt wall/cave.
		if(-INFINITY to GENERATION_SEGMENT_LOWEST - 0.1)
			if(density)
				if( rand_map(src,75) )
					new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new /obj/marker/generation/mob/goliath(src)
				else
					if(prob(25))
						new/turf/simulated/wall/ash/volcanic(src)
						new/obj/marker/generation/turf/ash_wall(src)
					else
						new /turf/simulated/wall/rock/basalt(src)
						if(prob(1))
							new /obj/marker/generation/turf/basalt_wall(src)
				if(prob(1))
					new /obj/marker/generation/ore/wall(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(1))
					new /obj/marker/generation/ore/floor(src)
		//Basalt floor, with sometimes lava.
		if(GENERATION_SEGMENT_LOWEST - 0.1 to GENERATION_SEGMENT_LOWEST)
			if(density)
				if( rand_map(src,50) )
					if(prob(1))
						new /turf/simulated/wall/rock/basalt(src)
						new /obj/marker/generation/turf/basalt_wall(src)
					else
						new /turf/simulated/floor/basalt(src)
						if(prob(0.5))
							new /obj/marker/generation/plant/embershroom_mushroom(src)
							new/obj/marker/generation/mob/watcher(src)
						else if(prob(1))
							new/obj/marker/generation/mob/slime/basalt(src)
				else
					if(prob(1))
						new/turf/simulated/floor/basalt(src)
						if(prob(5))
							new/obj/marker/generation/turf/basalt/island(src)
							if(prob(25))
								new/obj/marker/generation/plant/embershroom_mushroom(src)
							if(prob(50))
								new/obj/marker/generation/mob/watcher(src)
							else
								new/obj/marker/generation/mob/slime/magma(src)
					else
						new/turf/simulated/liquid/lava(src)
			else
				if(prob(1))
					new /turf/simulated/wall/rock/basalt(src)
					new /obj/marker/generation/turf/basalt_wall(src)
				else
					new /turf/simulated/floor/basalt(src)
					if(prob(0.5))
						new /obj/marker/generation/plant/glowcap(src)
					if(prob(1))
						new/obj/marker/generation/mob/slime/basalt(src)
				disallow_generation = TRUE
		//Lava, with sometimes basalt wall.
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			if(density)
				if(!rand_map(src,15) && rand_map(src,35))
					if(prob(1))
						new/turf/simulated/floor/basalt(src)
						if(prob(5))
							new/obj/marker/generation/turf/basalt/island(src)
							if(prob(25))
								new/obj/marker/generation/plant/embershroom_mushroom(src)
							if(prob(50))
								new/obj/marker/generation/mob/watcher(src)
							else
								new/obj/marker/generation/mob/slime/magma(src)
					else
						new/turf/simulated/liquid/lava(src)
				else
					if(prob(1))
						new/turf/simulated/wall/ash/volcanic(src)
						new/obj/marker/generation/turf/ash_wall(src)
					else
						new /turf/simulated/wall/rock/basalt(src)
					if(prob(1))
						new /obj/marker/generation/ore/wall(src)
					if(prob(1))
						new/obj/marker/generation/mob/goliath(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/embershroom_mushroom(src)
				else if(prob(0.5))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
				if(prob(1))
					new /obj/marker/generation/ore/floor(src)
		//Basalt floor, with a chance to be cave dirt.
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_LOW+0.1)
			if(density)
				if(rand_map(src,10))
					new/turf/simulated/floor/cave_dirt(src)
					if(prob(5))
						if(prob(75))
							new/obj/structure/scenery/rocks(src)
						else
							new/obj/structure/interactive/basalt(src)
						disallow_generation = TRUE
				else
					new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new/obj/marker/generation/mob/slime/basalt(src)
					if(prob(0.5))
						new/obj/marker/generation/plant/porcini_mushroom(src)
					if(prob(0.5))
						new /obj/marker/generation/plant/glowcap(src)
			else
				if(prob(5))
					new/turf/simulated/floor/basalt(src)
				else
					new/turf/simulated/floor/boss(src)
				if(prob(1))
					new/obj/marker/generation/turf/basalt(src)
				disallow_generation = TRUE
		//Always volcanic floor.
		if(GENERATION_SEGMENT_LOW+0.1 to GENERATION_SEGMENT_MID)
			if(density)
				new /turf/simulated/floor/colored/ash/volcanic(src)
				if(prob(6))
					new/obj/structure/interactive/basalt(src)
				if(prob(1))
					new /obj/marker/generation/mob/ash_walker(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/cactus_fruit(src)
			else
				if(prob(5))
					new/turf/simulated/floor/basalt(src)
				else
					new/turf/simulated/floor/boss(src)
				if(prob(1))
					new/obj/marker/generation/turf/basalt(src)
				if(prob(1))
					new /obj/marker/generation/mob/ash_walker(src)
				if(prob(0.5))
					new/obj/marker/generation/plant/polypore_mushroom(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Volcanic wall, with a chance to be cave dirt.
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_MID+0.1)
			if(density)
				if(rand_map(src,25))
					new/turf/simulated/floor/cave_dirt(src)
					if(prob(5))
						if(prob(75))
							new/obj/structure/scenery/rocks(src)
						else
							new/obj/structure/interactive/basalt(src)
						disallow_generation = TRUE
					if(prob(5))
						if(prob(25))
							new/obj/marker/generation/mob/gutlunch(src)
						new/obj/marker/generation/turf/cave_dirt(src)
						if(prob(25))
							new/obj/marker/generation/plant/inocybe_mushroom(src)
				else
					if(prob(1))
						new/turf/simulated/wall/rock/basalt(src)
						new/obj/marker/generation/turf/basalt_wall(src)
					else
						new/turf/simulated/wall/ash/volcanic(src)
					if(prob(1))
						new /obj/marker/generation/ore/wall(src)
			else
				if( rand_map(src,50) )
					new /turf/simulated/floor/colored/ash/volcanic(src)
					if(prob(6))
						new/obj/structure/interactive/basalt(src)
					if(prob(0.5))
						new /obj/marker/generation/plant/cactus_fruit(src)
				else
					if(prob(5))
						new/turf/simulated/floor/basalt(src)
					else
						new/turf/simulated/floor/boss(src)
					if(prob(0.5))
						new/obj/marker/generation/plant/polypore_mushroom(src)
					if(prob(1))
						new/obj/marker/generation/turf/basalt(src)
				if(prob(1))
					new /obj/marker/generation/mob/ash_walker(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Ash or Rock wall.
		if(GENERATION_SEGMENT_MID+0.1 to GENERATION_SEGMENT_HIGH)
			if(density)
				if( rand_map(src,50) )
					if(prob(1))
						new/turf/simulated/wall/rock/basalt(src)
						new/obj/marker/generation/turf/basalt_wall(src)
					else
						new/turf/simulated/wall/ash/volcanic(src)
				else
					new /turf/simulated/wall/rock/basalt(src)
					if(prob(1))
						new/obj/marker/generation/turf/ash_wall(src)
					if(prob(1))
						new/obj/marker/generation/mob/goliath(src)
				if(prob(1))
					new /obj/marker/generation/ore/wall(src)
			else
				if( rand_map(src,50) )
					new /turf/simulated/floor/colored/ash/volcanic(src)
					if(prob(6))
						new/obj/structure/interactive/basalt(src)
					if(prob(1))
						new /obj/marker/generation/mob/ash_walker(src)
					if(prob(0.5))
						new /obj/marker/generation/plant/cactus_fruit(src)
				else
					new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new/obj/marker/generation/turf/basalt(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/glowcap(src)
				if(prob(1))
					new /obj/marker/generation/ore/floor(src)
				disallow_generation = TRUE
		//Basalt with lava and rock holes.
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGH + 0.1)
			if(density)
				if( rand_map(src,50) )
					new /turf/simulated/wall/rock/basalt(src)
				else
					if(prob(5))
						new/turf/simulated/liquid/lava(src)
						new/obj/marker/generation/turf/lava/floor_only(src)
						if(prob(25))
							new/obj/marker/generation/mob/watcher(src)
					else
						new /turf/simulated/floor/basalt(src)
			else
				if(rand_map(src,25) )
					if(prob(90))
						new/turf/simulated/floor/boss(src)
					else
						new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new/obj/marker/generation/turf/basalt(src)
					if(prob(1))
						new /obj/marker/generation/mob/ash_walker(src)
					if(prob(0.5))
						new/obj/marker/generation/plant/polypore_mushroom(src)
					if(prob(0.5))
						new /obj/marker/generation/plant/glowcap(src)
				else
					new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new/obj/marker/generation/turf/basalt(src)
				disallow_generation = TRUE
		//Basalt or Lava, or basalt path.
		if(GENERATION_SEGMENT_HIGH + 0.1 to GENERATION_SEGMENT_HIGHEST)
			if(density)
				if(prob(1))
					new/turf/simulated/floor/basalt(src)
					if(prob(5))
						new/obj/marker/generation/turf/basalt/island(src)
						if(prob(25))
							new/obj/marker/generation/plant/embershroom_mushroom(src)
						if(prob(25))
							new/obj/marker/generation/mob/watcher(src)
						else
							new/obj/marker/generation/mob/slime/basalt(src)
				else
					new/turf/simulated/liquid/lava(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(1))
					new/obj/marker/generation/turf/basalt(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Lava, or basalt path.
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(density)
				if(rand_map(src,10))
					new/turf/simulated/floor/basalt(src)
					if(prob(5))
						new/obj/marker/generation/turf/basalt/island(src)
						if(prob(25))
							new/obj/marker/generation/plant/embershroom_mushroom(src)
						if(prob(25))
							new/obj/marker/generation/mob/slime/basalt(src)
						else
							new/obj/marker/generation/mob/watcher(src)
				else
					new/turf/simulated/liquid/lava(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(0.5))
					new /obj/marker/generation/plant/glowcap(src)
				if(prob(1))
					new/obj/marker/generation/turf/basalt(src)
				if(prob(1))
					new/obj/marker/generation/mob/slime/magma(src)
				disallow_generation = TRUE

	if(src.loc.type == /area/) new /area/mission/lava(src)

	return ..()


/turf/unsimulated/generation/lava/pre_generate()
	var/x_seed = x / world.maxx
	var/y_seed = y / world.maxy
	. = ..()
	noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+9]]","[x_seed]","[y_seed]"))
	noise -= (y - 215) / (world.maxy - 215) //Subtracting encourages land.
	noise += y/world.maxy //Encourages lava at higher altitudes.
	noise = MODULUS(noise,1)

