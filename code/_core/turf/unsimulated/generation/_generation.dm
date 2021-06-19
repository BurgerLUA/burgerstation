/turf/unsimulated/generation
	icon = 'icons/turf/generation.dmi'
	var/is_different = FALSE
	var/no_wall = FALSE

/turf/unsimulated/generation/proc/pre_generate()

	for(var/k in list(NORTH,EAST,SOUTH,WEST))
		var/turf/T = get_step(src,k)
		if(T && !istype(T,src))
			is_different = TRUE
			break

	return TRUE

/turf/unsimulated/generation/proc/generate(var/size = WORLD_SIZE)
	return TRUE

/turf/unsimulated/generation/lava_deep
	name = "deep lava generation"
	icon_state = "lava"

/turf/unsimulated/generation/lava_deep/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/basalt(src)
		return ..()

	var/noise = 0

	var/instances = 3

	for(var/i=1,i<=instances,i++) //Use sin/cosine?

		var/used_x = WRAP(x + i*WORLD_SIZE*0.25,1,255)
		var/used_y = WRAP(y + i*WORLD_SIZE*0.25,1,255)

		var/seed_resolution = WORLD_SIZE * 0.5
		var/x_seed = used_x / seed_resolution
		if(x_seed > 1)
			x_seed = 1 - (x_seed - 1)
		var/y_seed = used_y / seed_resolution
		if(y_seed > 1)
			y_seed = 1 - (y_seed - 1)
		var/found = text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[1] + i]","[x_seed]","[y_seed]"))
		noise += found

	noise = (noise/instances) + rand(-100,100)/10000

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.1)
			new /turf/simulated/hazard/lava(src)
		if(0.1 to 0.2)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/lava(src)
		if(0.2 to 0.4)
			new /turf/simulated/hazard/lava(src)
			if(prob(1))
				new /obj/marker/generation/basalt(src)
		if(0.4 to 0.6)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
		if(0.6 to 0.8)
			new /turf/simulated/hazard/lava(src)
			if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
		if(0.8 to INFINITY)
			new /turf/simulated/wall/rock/basalt(src)

	return ..()

/turf/unsimulated/generation/lava
	name = "lava generation"
	icon_state = "lava"

/turf/unsimulated/generation/lava/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/basalt(src)
		return ..()

	var/noise = 0

	var/instances = 2

	for(var/i=1,i<=instances,i++) //Use sin/cosine?

		var/used_x = WRAP(x + i*WORLD_SIZE*0.25,1,255)
		var/used_y = WRAP(y + i*WORLD_SIZE*0.25,1,255)

		var/seed_resolution = WORLD_SIZE * 0.5
		var/x_seed = used_x / seed_resolution
		if(x_seed > 1)
			x_seed = 1 - (x_seed - 1)
		var/y_seed = used_y / seed_resolution
		if(y_seed > 1)
			y_seed = 1 - (y_seed - 1)
		var/found = text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[1] + i]","[x_seed]","[y_seed]"))
		noise += found

	noise = (noise/instances) + rand(-100,100)/10000

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.1)
			new /turf/simulated/floor/basalt(src)
			if(prob(5))
				new /obj/marker/generation/lava(src)
		if(0.1 to 0.2)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/lava(src)
			else if(prob(1))
				new /obj/marker/generation/ash_floor(src)
		if(0.2 to 0.4)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/lava(src)
			else if(prob(1))
				new /obj/marker/generation/ash_floor(src)
		if(0.4 to 0.6)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
			else if(prob(1))
				new /obj/marker/generation/ash_wall(src)
		if(0.6 to 0.8)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/lava(src)
			else if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
			else if(prob(1))
				new /obj/marker/generation/ash_wall(src)
		if(0.8 to INFINITY)
			new /turf/simulated/wall/rock/basalt(src)
			if(prob(1))
				new /obj/marker/generation/ash_wall(src)

	return ..()



/turf/unsimulated/generation/forest
	name = "forest generation"
	icon_state = "forest"

/turf/unsimulated/generation/forest/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/grass(src)
		return ..()

	var/noise = 0

	var/instances = 2

	for(var/i=1,i<=instances,i++) //Use sin/cosine?

		var/used_x = WRAP(x + i*WORLD_SIZE*0.25,1,255)
		var/used_y = WRAP(y + i*WORLD_SIZE*0.25,1,255)

		var/seed_resolution = WORLD_SIZE * 0.5
		var/x_seed = used_x / seed_resolution
		if(x_seed > 1)
			x_seed = 1 - (x_seed - 1)
		var/y_seed = used_y / seed_resolution
		if(y_seed > 1)
			y_seed = 1 - (y_seed - 1)
		var/found = text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[2] + i]","[x_seed]","[y_seed]"))
		noise += found

	noise = (noise/instances)

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.05)
			new /turf/simulated/hazard/water(src)
		if(0.05 to 0.08)
			new /turf/simulated/floor/colored/sand/beach(src)
			if(prob(1))
				new /mob/living/simple/crab(src)
			else if(prob(2))
				new /obj/marker/generation/plant/sugarcane(src)
		if(0.08 to 0.1)
			new /turf/simulated/floor/colored/dirt(src)
		if(0.1 to 0.42)
			new /turf/simulated/floor/colored/grass(src)
			if(prob(10))
				new /obj/marker/generation/forest_tree(src)
				if(prob(50))
					new /obj/marker/generation/mob/chicken
			else if(prob(2))
				new /obj/marker/generation/plant/wheat(src)
			else if(prob(2))
				new /obj/marker/generation/plant/chanterelle(src)
			else if(prob(10))
				new /obj/marker/generation/forest_grass(src)
		if(0.42 to 0.44)
			new /turf/simulated/floor/colored/dirt(src)
		if(0.44 to 0.94)
			new /turf/simulated/floor/colored/grass(src)
			if(prob(2))
				new /obj/marker/generation/plant/fly_amanita(src)
			else if(prob(0.5))
				new /obj/marker/generation/plant/tomato(src)
			else if(prob(5))
				new /obj/marker/generation/forest_tree(src)
			else if(prob(10))
				new /obj/marker/generation/forest_grass(src)
				if(prob(5))
					new /obj/marker/generation/mob/cow(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt(src)
		if(0.95 to INFINITY)
			new /turf/simulated/hazard/water(src)

	return ..()


/turf/unsimulated/virtual_reality
	name = "virtual reality"

	icon = 'icons/turf/floor/circuit.dmi'
	icon_state = "gcircuit"