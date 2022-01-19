/turf/unsimulated/generation/snow_cave
	name = "snow cave generation"
	icon_state = "snow_caves"

/turf/unsimulated/generation/snow_cave/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/dirt/cave(src)
		return ..()

	var/seed_resolution = max(world.maxx,world.maxy)
	var/x_seed = x / seed_resolution
	var/y_seed = y / seed_resolution

	var/max_instances = 3
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances

	switch(noise)
		if(-INFINITY to 0.2)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(1)) new /obj/marker/generation/foliage/grass/snow(src)
			if(prob(1)) new /obj/marker/generation/foliage/tree/snow(src)
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
	icon_state = "snow_caves_path"

/turf/unsimulated/generation/snow_cave/path/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/dirt/cave(src)
		disallow_generation = TRUE
		return ..()

	new /turf/simulated/floor/cave_dirt(src)
	disallow_generation = TRUE
	return TRUE