/turf/unsimulated/generation/snow
	name = "snow generation"
	icon_state = "snow"

/turf/unsimulated/generation/snow/generate(var/size = WORLD_SIZE)

	if(x <= 10 || y <= 10 || x >= world.maxx-10 || y >= world.maxy-10)
		if(!allow_wall)
			new /turf/simulated/floor/cave_dirt(src)
		else
			new /turf/simulated/wall/rock/snow(src)
			if(prob(10))
				new /obj/marker/generation/snow_wall(src)
		if(src.loc.type == /area/) new /area/dungeon/z_01/snow/interior(src)
		return ..()

	if(!allow_wall)
		new /turf/simulated/floor/colored/snow(src)
		if(src.loc.type == /area/) new /area/dungeon/z_01/snow(src)
		return ..()

	var/seed_resolution = max(world.maxx,world.maxy)
	var/x_seed = x / seed_resolution
	var/y_seed = y / seed_resolution

	var/max_instances = 3
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.1)
			new /turf/simulated/wall/rock/snow(src)
		if(0.1 to 0.4)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(4))
				new /obj/marker/generation/foliage/grass/snow(src)
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
			else if(prob(1))
				new /obj/marker/generation/foliage/tree/snow(src)
			else if(prob(6))
				new /obj/marker/generation/foliage/grass/snow(src)
			else if(prob(0.2))
				new /obj/marker/generation/mob/snow_bear(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.95 to INFINITY)
			new /turf/simulated/wall/rock/snow(src)

	if(src.loc.type == /area/) new /area/dungeon/z_01/snow(src)

	return ..()

/turf/unsimulated/generation/snow/path
	icon_state = "snow_path"


/turf/unsimulated/generation/snow/path/generate(var/size = WORLD_SIZE)

	if(!allow_wall)
		new /turf/simulated/floor/colored/snow(src)
		if(src.loc.type == /area/) new /area/dungeon/z_01/snow(src)
		disallow_generation = TRUE
		return ..()

	var/seed_resolution = max(world.maxx,world.maxy)
	var/x_seed = x / seed_resolution
	var/y_seed = y / seed_resolution

	var/max_instances = 3
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances

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
				new /obj/marker/generation/mob/snow_bear(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.95 to INFINITY)
			new /turf/simulated/floor/cave_dirt(src)

	if(src.loc.type == /area/) new /area/dungeon/z_01/snow(src)
	disallow_generation = TRUE

	if(prob(0.5))
		new /obj/marker/generation/mob/rev(src)

	return ..()