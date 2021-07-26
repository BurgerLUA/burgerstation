/turf/unsimulated/generation/snow
	name = "snow generation"
	icon_state = "snow"

/turf/unsimulated/generation/snow/generate(var/size = WORLD_SIZE)

	if(x <= 10 || y <= 10 || x >= 245 || y >= 245)
		if(no_wall)
			new /turf/simulated/floor/cave_dirt(src)
		else
			new /turf/simulated/wall/rock/snow(src)
			if(prob(10))
				new /obj/marker/generation/snow_wall(src)
		return ..()

	if(no_wall)
		new /turf/simulated/floor/colored/snow(src)
		return ..()

	var/noise = 0

	var/instances = 4

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
		if(-INFINITY to 0.1)
			new /turf/simulated/wall/rock/snow(src)
		if(0.1 to 0.4)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(4))
				new /obj/marker/generation/snow_grass(src)
			else if(prob(2))
				new /obj/marker/generation/plant/oxygen_fruit(src)
		if(0.4 to 0.41)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.41 to 0.43)
			new /turf/simulated/wall/rock/snow(src)
		if(0.43 to 0.44)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.44 to 0.94)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(1))
				new /obj/marker/generation/plant/nitrogen_flower(src)
			else if(prob(0.5))
				new /obj/marker/generation/mob/snow_bear(src)
			else if(prob(1))
				new /obj/marker/generation/snow_tree(src)
			else if(prob(6))
				new /obj/marker/generation/snow_grass(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.95 to INFINITY)
			new /turf/simulated/wall/rock/snow(src)

	return ..()

/turf/unsimulated/generation/snow/path
	icon_state = "snow_path"


/turf/unsimulated/generation/snow/path/generate(var/size = WORLD_SIZE)

	if(no_wall)
		new /turf/simulated/floor/colored/snow(src)
		return ..()

	var/noise = 0

	var/instances = 4

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
		if(-INFINITY to 0.1)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.1 to 0.4)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(4))
				new /obj/marker/generation/snow_grass(src)
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
			else if(prob(0.5))
				new /obj/marker/generation/mob/snow_bear(src)
			else if(prob(6))
				new /obj/marker/generation/snow_grass(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.95 to INFINITY)
			new /turf/simulated/floor/cave_dirt(src)

	return ..()






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
		return ..()

	new /turf/simulated/floor/cave_dirt(src)
	if(prob(0.25)) new /obj/marker/generation/rock_wall(src)
	return TRUE