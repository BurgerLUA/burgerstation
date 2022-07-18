/turf/unsimulated/generation/forest_cave
	name = "cave generation"
	icon_state = "caves"

/turf/unsimulated/generation/forest_cave/path
	icon_state = "caves_path"
	allow_wall = FALSE

/turf/unsimulated/generation/forest_cave/generate(var/size = WORLD_SIZE)

	if(!allow_wall)
		new /turf/simulated/floor/colored/dirt/cave(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
		disallow_generation = TRUE
		return ..()

	if(is_different && is_next_to_null_area)
		new /turf/simulated/wall/rock(src)
		if(prob(5))
			new /obj/marker/generation/rock_wall/small(src)
		else if(prob(1))
			new /obj/marker/generation/rock_wall(src)
		if(src.loc.type == /area/) new /area/mission/caves(src)
		disallow_generation = TRUE
		return ..()

	var/x_seed = x / size
	var/y_seed = y / size

	var/max_instances = 3
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances

	switch(noise)
		if(-INFINITY to 0.2)
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
			if(prob(1))
				new /turf/simulated/floor/cave_dirt(src)
				new /obj/marker/generation/cave_dirt(src)
			else
				new /turf/simulated/wall/rock(src)
				if(prob(1))
					new /obj/marker/generation/rock_wall(src)
		if(0.6 to 0.75)
			new /turf/simulated/liquid/water/cave(src)
		if(0.75 to 0.8)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(3))
				new /obj/marker/generation/cave_dirt_colored(src)
		if(0.8 to 1)
			if(prob(1))
				new /turf/simulated/floor/cave_dirt(src)
				new /obj/marker/generation/cave_dirt(src)
			else
				new /turf/simulated/wall/rock(src)
				if(prob(1))
					new /obj/marker/generation/rock_wall(src)

	if(src.loc.type == /area/)
		new /area/mission/caves(src)

	. = ..()