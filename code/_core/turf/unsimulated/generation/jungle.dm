/turf/unsimulated/generation/jungle
	name = "jungle generation"
	icon_state = "jungle"
	var/path_only = FALSE

/turf/unsimulated/generation/jungle/path
	icon_state = "jungle_path"
	path_only = TRUE

/turf/unsimulated/generation/jungle/generate(var/size = WORLD_SIZE)

	var/shitfix = path_only

	if(no_wall)
		new /turf/simulated/floor/colored/dirt/jungle(src)
		disallow_generation = TRUE
		return ..()

	var/seed_resolution = WORLD_SIZE
	var/x_seed = x / seed_resolution
	var/y_seed = y / seed_resolution

	var/max_instances = 1
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances
	if(prob(5))
		noise += RAND_PRECISE(-0.01,0.01)

	switch(noise)
		if(-INFINITY to 0.05)
			if(!path_only)
				if(prob(5))
					new /obj/marker/generation/jungle_tree_small(src)
				else if(prob(2))
					new /obj/marker/generation/jungle_tree(src)
				else if(prob(1))
					new /obj/marker/generation/jungle_high_grass(src)
				else if(prob(4))
					new /obj/marker/generation/jungle_rock_grass(src)
				else if(prob(2))
					new /obj/marker/generation/bushes/fern(src)
			new /turf/simulated/floor/grass/jungle(src)
		if(0.05 to 0.12)
			if(!path_only && prob(1))
				new /obj/marker/generation/jungle_wall(src)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.12 to 0.13)
			if(!path_only && prob(1))
				new /obj/marker/generation/mob/arachnid(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.13 to 0.15)
			if(prob(10))
				new /obj/marker/generation/jungle_rock_grass(src)
			if(!path_only && prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
			new /turf/simulated/floor/colored/grass/jungle(src)
		if(0.15 to 0.4)
			if(!path_only)
				if(prob(5))
					new /obj/marker/generation/jungle_tree_small(src)
				else if(prob(2))
					new /obj/marker/generation/jungle_tree(src)
				else if(prob(1))
					new /obj/marker/generation/jungle_high_grass(src)
				else if(prob(4))
					new /obj/marker/generation/jungle_rock_grass(src)
				else if(prob(2))
					new /obj/marker/generation/bushes/fern(src)
				if(!path_only && prob(1))
					new /obj/marker/generation/mob/venus_human_trap(src)
			new /turf/simulated/floor/grass/jungle(src)
		if(0.4 to 0.42)
			if(prob(5))
				new /obj/marker/generation/jungle_rock_grass(src)
			if(!path_only && prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
			new /turf/simulated/floor/colored/grass/jungle(src)
		if(0.42 to 0.44)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/jungle(src)
			else
				new /turf/simulated/hazard/water/jungle(src)
				if(prob(5))
					new /obj/marker/generation/water/jungle(src)
		if(0.44 to 0.45)
			if(!path_only && prob(1))
				new /obj/marker/generation/mob/arachnid(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.45 to 0.47)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/jungle(src)
			else
				new /turf/simulated/wall/rock/brown(src)
		if(0.47 to 0.48)
			if(!path_only && prob(1))
				new /obj/marker/generation/mob/arachnid(src)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.48 to 0.85)
			if(!path_only)
				if(prob(5))
					new /obj/marker/generation/jungle_tree_small(src)
				else if(prob(2))
					new /obj/marker/generation/jungle_tree(src)
				else if(prob(1))
					new /obj/marker/generation/jungle_high_grass(src)
				else if(prob(4))
					new /obj/marker/generation/jungle_rock_grass(src)
				else if(prob(2))
					new /obj/marker/generation/bushes/fern(src)
				if(!path_only && prob(1))
					new /obj/marker/generation/mob/venus_human_trap(src)
			new /turf/simulated/floor/grass/jungle(src)
		if(0.85 to 0.87)
			if(prob(5))
				new /obj/marker/generation/jungle_rock_grass(src)
			if(!path_only && prob(1))
				new /obj/marker/generation/mob/venus_human_trap(src)
			new /turf/simulated/floor/colored/grass/jungle(src)
		if(0.87 to 0.9)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/jungle(src)
			else
				new /turf/simulated/hazard/water(src)
		if(0.9 to INFINITY)
			if(path_only)
				new /turf/simulated/floor/colored/dirt/jungle(src)
				if(prob(5))
					new /obj/structure/scenery/rocks(src)
			else
				new /turf/simulated/hazard/water(src)
				if(prob(5))
					new /obj/marker/generation/water/jungle(src)

	if(shitfix)
		disallow_generation = TRUE

	return ..()