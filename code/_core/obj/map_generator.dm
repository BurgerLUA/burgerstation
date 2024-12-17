/obj/map_generator
	name = "map generator"
	invisibility = 101

/obj/map_generator/proc/generate_map()

	var/list/possible_t1 = list( //Outer edge.
		"snow",
		"desert",
		"forest",
		"ocean",
		"jungle"
	)

	var/list/possible_t2 = list( //Middle edge.
		"cave",
		"lava_cave",
		"ocean"
	)

	var/list/possible_t3 = list( //Center edge.
		"lava",
		"jungle",
		"snow",
		"desert"
	)

	var/chosen_t1 = pick(possible_t1)
	possible_t2 -= chosen_t1
	possible_t3 -= chosen_t1
	if(chosen_t1 == "jungle")
		possible_t2 += "jungle_deep"
		possible_t3 += "jungle_deep"

	var/chosen_t2 = pick(possible_t2)
	possible_t3 -= chosen_t2
	switch(chosen_t2)
		if("lava_cave")
			possible_t3 += "ash"
			possible_t3 -= "snow"
		if("ocean")
			possible_t3 -= "lava"
			possible_t3 -= "lava_cave"

	var/chosen_t3 = pick(possible_t3)

	var/center_x = CEILING(world.maxx/2,1)
	var/center_y = CEILING(world.maxy/2,1)

	var/list/biome_tag_to_turf = list(
		"snow" = list(
			/turf/unsimulated/generation/snow,
			/turf/unsimulated/generation/snow/path
		),
		"desert" = list(
			/turf/unsimulated/generation/snow,
			/turf/unsimulated/generation/snow/path
		),
		"forest" = list(
			/turf/unsimulated/generation/forest,
			/turf/unsimulated/generation/forest/path
		),
		"ocean" = list(
			/turf/unsimulated/generation/forest,
			/turf/unsimulated/generation/forest/path
		),
		"jungle" = list(
			/turf/unsimulated/generation/jungle,
			/turf/unsimulated/generation/jungle/path
		),
		"jungle_deep" = list(
			/turf/unsimulated/generation/jungle_deep,
			/turf/unsimulated/generation/jungle_deep/path
		),
		"cave" = list(
			/turf/unsimulated/generation/forest_cave,
			/turf/unsimulated/generation/forest_cave/path
		),
		"lava_cave" = list(
			/turf/unsimulated/generation/forest_cave,
			/turf/unsimulated/generation/forest_cave/path
		),
		"lava" = list(
			/turf/unsimulated/generation/lava,
			/turf/unsimulated/generation/lava
		),
		"ash" = list(
			/turf/unsimulated/generation/lava,
			/turf/unsimulated/generation/lava
		)
	)

	for(var/x=1,x<=world.maxx,x++)
		for(var/y=1,y<=world.maxy,y++)
			var/turf/T = locate(x,y,z)
			if(x == world.maxx || x == 1 || y == world.maxy || y == 1)
				new /turf/simulated/wall/rock/indestructable(T)
				continue
			var/noise_setting = text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[3] + z]","[x/world.maxx]","[y/world.maxy]"))
			var/distance_from_center = sqrt( ((center_x - x)**2) + ((center_y - y)**2) )
			var/list/biome_to_use = list()
			switch(distance_from_center)
				if(0 to WORLD_SIZE*0.25)
					biome_to_use = biome_tag_to_turf[chosen_t3]
				if(WORLD_SIZE*0.25 to WORLD_SIZE*0.7)
					biome_to_use = biome_tag_to_turf[chosen_t2]
				if(WORLD_SIZE*0.7 to WORLD_SIZE)
					biome_to_use = biome_tag_to_turf[chosen_t1]
			var/turf/N
			if(noise_setting <= 0.25)
				N = biome_to_use[2]
			else
				N = biome_to_use[1]
			N = new N(T)
			if(noise_setting <= 0.1)
				N.disallow_generation = TRUE
				var/obj/marker/map_node/O = locate() in view(N,VIEW_RANGE*0.5)
				if(!O)
					O = new(N)
			sleep(-1)

	qdel(src)
