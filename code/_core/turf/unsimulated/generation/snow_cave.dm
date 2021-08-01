/turf/unsimulated/generation/snow_cave
	name = "snow cave generation"
	icon_state = "caves"

/turf/unsimulated/generation/snow_cave/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/dirt/cave(src)
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

	switch(noise)
		if(-INFINITY to 0.2)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(1)) new /obj/marker/generation/snow_grass(src)
			if(prob(1)) new /obj/marker/generation/snow_tree(src)
		if(0.2 to 0.3)
			new /turf/simulated/wall/rock/snow(src)
			if(prob(1)) new /obj/marker/generation/snow_wall(src)
		if(0.3 to 0.5)
			if(is_different)
				new /obj/marker/generation/snow_wall(src)
			else
				new /turf/simulated/wall/rock(src)
				if(prob(1)) new /obj/marker/generation/rock_wall(src)
		if(0.5 to 0.8)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(1)) new /obj/marker/generation/rock_wall(src)
		if(0.8 to 0.9)
			if(is_different)
				new /obj/marker/generation/snow_wall(src)
			else
				new /turf/simulated/wall/rock(src)
				if(prob(1)) new /obj/marker/generation/rock_wall(src)
		if(0.9 to INFINITY)
			new /turf/simulated/wall/rock/snow(src)
			if(prob(1)) new /obj/marker/generation/snow_wall(src)

	return ..()


/turf/unsimulated/generation/snow_cave/path
	icon_state = "caves_path"

/turf/unsimulated/generation/snow_cave/path/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/dirt/cave(src)
		disallow_generation = TRUE
		return ..()

	new /turf/simulated/floor/cave_dirt(src)
	disallow_generation = TRUE
	return TRUE