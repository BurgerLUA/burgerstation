/turf/unsimulated/generation/jungle
	name = "jungle generation"
	icon_state = "jungle"
	var/path_only = FALSE

/turf/unsimulated/generation/jungle/path
	icon_state = "jungle_path"
	path_only = TRUE

/turf/unsimulated/generation/jungle/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/dirt/jungle(src)
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
		var/found = text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[2] + i]","[x_seed]","[y_seed]"))
		noise += found

	noise = (noise/instances)

	switch(noise)
		if(-INFINITY to 0.05)
			if(path_only)
				new /turf/simulated/floor/basalt(src)
			else
				new /turf/simulated/wall/rock/basalt(src)
		if(0.05 to 0.1)
			if(path_only)
				new /turf/simulated/floor/basalt(src)
			else
				new /turf/simulated/hazard/lava(src)
		if(0.1 to 0.11)
			new /turf/simulated/floor/basalt(src)
		if(0.11 to 0.12)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.12 to 0.13)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.13 to 0.15)
			new /turf/simulated/floor/colored/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_rock_grass(src)
		if(0.15 to 0.4)
			if(prob(10))
				new /obj/marker/generation/jungle_high_grass(src)
			else if(!path_only)
				if(prob(3))
					new /obj/marker/generation/jungle_tree_small(src)
				else if(prob(2))
					new /obj/marker/generation/jungle_tree(src)
			new /turf/simulated/floor/grass/jungle(src)
		if(0.40 to 0.42)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.42 to 0.43)
			new /turf/simulated/floor/colored/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_rock_grass(src)
		if(0.43 to 0.44)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/jungle(src)
			else
				new /turf/simulated/hazard/water(src)
		if(0.4 to 0.45)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.45 to 0.47)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/jungle(src)
			else
				new /turf/simulated/wall/rock/brown(src)
		if(0.47 to 0.48)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.48 to 0.75)
			if(prob(10))
				new /obj/marker/generation/jungle_high_grass(src)
			else if(!path_only)
				if(prob(3))
					new /obj/marker/generation/jungle_tree_small(src)
				else if(prob(2))
					new /obj/marker/generation/jungle_tree(src)
			new /turf/simulated/floor/grass/jungle(src)
		if(0.75 to 0.8)
			new /turf/simulated/floor/colored/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_rock_grass(src)
		if(0.8 to 0.9)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/jungle(src)
			else
				new /turf/simulated/hazard/water(src)
		if(0.9 to INFINITY)
			new /turf/simulated/floor/colored/dirt/jungle(src)

	return ..()