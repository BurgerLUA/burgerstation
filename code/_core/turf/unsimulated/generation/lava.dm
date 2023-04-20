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
		if(density && is_next_to_null_area && is_next_to_dense_turf && !is_next_to_simulated)
			new /turf/simulated/wall/rock/basalt(src)
			if(prob(1))
				new/obj/marker/generation/turf/ash_wall(src)
			if(prob(1))
				new/obj/marker/generation/mob/goliath(src)
		else
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/plant/glowcap(src)
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	switch(noise)
		//Basalt floor, with sometimes lava.
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			if(density)
				if( y/size <= noise*0.5 )
					new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new /obj/marker/generation/plant/embershroom_mushroom(src)
				else
					if(prob(1))
						new/turf/simulated/floor/basalt(src)
						new/obj/marker/generation/turf/basalt/island(src)
						new/obj/marker/generation/plant/embershroom_mushroom(src)
						new/obj/marker/generation/mob/watcher(src)
					else
						new/turf/simulated/liquid/lava(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(2))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Lava, with sometimes basalt wall.
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			if(density)
				if( y/size <= noise*0.5 )
					if(prob(1))
						new/turf/simulated/floor/basalt(src)
						new/obj/marker/generation/turf/basalt/island(src)
						new/obj/marker/generation/plant/embershroom_mushroom(src)
						new/obj/marker/generation/mob/watcher(src)
					else
						new/turf/simulated/liquid/lava(src)
				else
					new /turf/simulated/wall/rock/basalt(src)
					if(prob(1))
						new/obj/marker/generation/turf/ash_wall(src)
					if(prob(1))
						new/obj/marker/generation/mob/goliath(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(1))
					new /obj/marker/generation/plant/embershroom_mushroom(src)
				else if(prob(1))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Always basalt floor.
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_LOW+0.1)
			if(density)
				new /turf/simulated/floor/basalt(src)
				if(prob(1))
					new/obj/marker/generation/plant/porcini_mushroom(src)
				if(prob(2))
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
				if(prob(1))
					new /obj/marker/generation/mob/ash_walker(src)
				if(prob(1))
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
				if(prob(2))
					new/obj/marker/generation/plant/polypore_mushroom(src)
				if(prob(2))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Volcanic wall, with a chance to be cave dirt.
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_MID+0.1)
			if(density)
				if(y/size <= noise*0.75 )
					new/turf/simulated/floor/cave_dirt(src)
					if(prob(5))
						new/obj/marker/generation/mob/gutlunch(src)
						new/obj/marker/generation/turf/cave_dirt(src)
						new/obj/marker/generation/plant/inocybe_mushroom(src)
				else
					if(prob(1))
						new/turf/simulated/wall/rock/basalt(src)
						new/obj/marker/generation/turf/basalt_wall(src)
					else
						new/turf/simulated/wall/ash/volcanic(src)
			else
				if( y/size <= noise*0.5 )
					new /turf/simulated/floor/colored/ash/volcanic(src)
					if(prob(1))
						new /obj/marker/generation/plant/cactus_fruit(src)
				else
					if(prob(5))
						new/turf/simulated/floor/basalt(src)
					else
						new/turf/simulated/floor/boss(src)
					if(prob(2))
						new/obj/marker/generation/plant/polypore_mushroom(src)
					if(prob(1))
						new/obj/marker/generation/turf/basalt(src)
				if(prob(1))
					new /obj/marker/generation/mob/ash_walker(src)
				if(prob(2))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Ash or Rock wall.
		if(GENERATION_SEGMENT_MID+0.1 to GENERATION_SEGMENT_HIGH)
			if(density)
				if( y/size <= noise*0.5 )
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
			else
				if( y/size <= noise*0.5 )
					new /turf/simulated/floor/colored/ash/volcanic(src)
					if(prob(1))
						new /obj/marker/generation/mob/ash_walker(src)
					if(prob(1))
						new /obj/marker/generation/plant/cactus_fruit(src)
				else
					new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new/obj/marker/generation/turf/basalt(src)
				if(prob(2))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Always Basalt
		if(GENERATION_SEGMENT_HIGH - 0.1 to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new/obj/marker/generation/turf/basalt(src)
		//Basalt or Lava, or basalt path.
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			if(density)
				if( y/size <= noise*0.5 )
					new /turf/simulated/floor/basalt(src)
					if(prob(1))
						new/obj/marker/generation/turf/basalt(src)
				else
					if(prob(1))
						new/turf/simulated/floor/basalt(src)
						new/obj/marker/generation/turf/basalt/island(src)
						new/obj/marker/generation/plant/embershroom_mushroom(src)
						new/obj/marker/generation/mob/watcher(src)
					else
						new/turf/simulated/liquid/lava(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(1))
					new/obj/marker/generation/turf/basalt(src)
				if(prob(2))
					new /obj/marker/generation/plant/glowcap(src)
				disallow_generation = TRUE
		//Lava, or basalt path.
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(density)
				if(prob(1))
					new/turf/simulated/floor/basalt(src)
					new/obj/marker/generation/turf/basalt/island(src)
					new/obj/marker/generation/plant/embershroom_mushroom(src)
					new/obj/marker/generation/mob/watcher(src)
				else
					new/turf/simulated/liquid/lava(src)
			else
				new /turf/simulated/floor/basalt(src)
				if(prob(2))
					new /obj/marker/generation/plant/glowcap(src)
				if(prob(1))
					new/obj/marker/generation/turf/basalt(src)
				disallow_generation = TRUE

	if(src.loc.type == /area/) new /area/mission/lava(src)

	return ..()


/turf/unsimulated/generation/lava/pre_generate()
	var/x_seed = x / world.maxx
	var/y_seed = y / world.maxy
	. = ..()
	noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+9]]","[x_seed]","[y_seed]"))
	noise += (y - 215) / (world.maxy - 215)
	noise = MODULUS(noise,1)

