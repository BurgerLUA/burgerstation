/turf/unsimulated/generation/snow_cave
	name = "snow cave generation"
	icon_state = "snow_caves"

/turf/unsimulated/generation/snow_cave/path
	icon_state = "snow_caves_path"
	density = FALSE

/turf/unsimulated/generation/snow_cave/generate(var/size = WORLD_SIZE)

	var/shitfix = path_only

	if(!density)
		new /turf/simulated/floor/colored/dirt/cave(src)
		if(src.loc.type == /area/) new /area/dungeon/z_01/snow/interior(src)
		disallow_generation = TRUE
		return ..()

	if(!is_next_to_interior && is_different && density && !is_next_to_dense_turf)
		new /turf/simulated/wall/rock/snow(src)
		if(src.loc.type == /area/) new /area/dungeon/z_01/snow/interior(src)
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
	noise = 0.5 + sin((noise+0.5)*3*180)*0.5
	noise += (x/world.maxx + y/world.maxy)/2 - 0.5


	var/needs_bear = !density

	switch(noise)
		if(-INFINITY to 0.2)
			if(!density)
				new /turf/simulated/floor/cave_dirt(src)
			else
				if(prob(1))
					new /turf/simulated/floor/cave_dirt(src)
					new /obj/marker/generation/cave_dirt(src)
				else
					new /turf/simulated/wall/rock(src)
					if(prob(1))
						new /obj/marker/generation/rock_wall(src)
		if(0.2 to 0.23)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.23 to 0.28)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(3))
				new /obj/marker/generation/cave_dirt_colored(src)
		if(0.28 to 0.38)
			if(!density)
				new /turf/simulated/floor/cave_dirt(src)
			else
				if(prob(1))
					new /turf/simulated/floor/cave_dirt(src)
					new /obj/marker/generation/cave_dirt(src)
				else
					new /turf/simulated/wall/rock(src)
					if(prob(1))
						new /obj/marker/generation/rock_wall(src)
		if(0.38 to 0.5)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(3))
				new /obj/marker/generation/cave_dirt_colored(src)
		if(0.5 to 0.53)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.53 to 0.6)
			if(!density)
				new /turf/simulated/floor/cave_dirt(src)
			else
				if(prob(1))
					new /turf/simulated/floor/cave_dirt(src)
					new /obj/marker/generation/cave_dirt(src)
				else
					new /turf/simulated/wall/rock(src)
					if(prob(1))
						new /obj/marker/generation/rock_wall(src)
		if(0.6 to 0.75)
			if(!density)
				new /turf/simulated/floor/cave_dirt(src)
			else
				new /turf/simulated/liquid/water/river/ice(src)
		if(0.75 to 0.8)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(3))
				new /obj/marker/generation/cave_dirt_colored(src)
		if(0.8 to INFINITY)
			if(!density)
				new /turf/simulated/floor/cave_dirt(src)
			else
				if(prob(1))
					new /turf/simulated/floor/cave_dirt(src)
					new /obj/marker/generation/cave_dirt(src)
				else
					new /turf/simulated/wall/rock(src)
					if(prob(1))
						new /obj/marker/generation/rock_wall(src)

	if(is_floor(src))
		if(prob(0.5))
			if(prob(20))
				new /obj/marker/generation/mob/mouse/white(src)
			else
				new /obj/marker/generation/mob/cave_spider(src)
		else if(needs_bear && prob(1))
			new /obj/marker/generation/mob/snow_bear(src)

	if(src.loc.type == /area/) new /area/dungeon/z_01/snow/interior(src)

	if(shitfix)
		disallow_generation = TRUE

	return ..()