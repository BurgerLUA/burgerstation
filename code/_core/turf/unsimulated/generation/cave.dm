/turf/unsimulated/generation/cave
	name = "lava generation"
	icon_state = "caves"
	var/path_only = FALSE

/turf/unsimulated/generation/cave/path
	icon_state = "caves_path"
	path_only = TRUE

/turf/unsimulated/generation/cave/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/dirt/cave(src)
		return ..()

	var/seed_resolution = WORLD_SIZE
	var/x_seed = x / seed_resolution
	var/y_seed = y / seed_resolution

	var/max_instances = 1
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances

	switch(noise)
		if(-INFINITY to 0.1)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/cave(src)
				if(prob(2))
					new /obj/marker/generation/cave_dirt(src)
			else
				new /turf/simulated/wall/rock(src)
				if(prob(1))
					new /obj/marker/generation/rock_wall/small(src)
		if(0.1 to 0.15)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(1))
				new /obj/marker/generation/cave_dirt(src)
		if(0.15 to 0.4)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/cave(src)
				if(prob(2))
					new /obj/marker/generation/cave_dirt(src)
			else
				new /turf/simulated/wall/rock(src)
				if(prob(1))
					new /obj/marker/generation/rock_wall/small(src)
		if(0.4 to 0.8)
			if(prob(1))
				new /obj/marker/generation/cave_dirt(src)
			else if(!path_only && prob(1))
				new /obj/marker/generation/rock_wall(src)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.8 to INFINITY)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/cave(src)
				if(prob(2))
					new /obj/marker/generation/cave_dirt(src)
			else
				new /turf/simulated/wall/rock(src)
				if(prob(1))
					new /obj/marker/generation/rock_wall/small(src)

	return ..()