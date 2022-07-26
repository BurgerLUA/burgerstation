/turf/unsimulated/generation/desert
	name = "desert generation"
	icon_state = "desert"

/turf/unsimulated/generation/desert/path
	icon_state = "desert_path"
	allow_wall = FALSE

/turf/unsimulated/generation/desert/generate(var/size = WORLD_SIZE)

	if(!allow_wall)
		new /turf/simulated/floor/colored/sand/desert(src)
		if(src.loc.type == /area/) new /area/mission/desert(src)
		disallow_generation = TRUE
		return ..()

	var/x_seed = x / size
	var/y_seed = y / size

	var/max_instances = 3
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances
	noise = 0.5 + sin((noise+0.5)*3*180)*0.5


	var/interior = FALSE
	switch(noise) //0.5 is most common. 0 and 1 is least common.
		if(-INFINITY to 0.1)
			interior = TRUE
			new /turf/simulated/wall/rock/desert(src)
			if(prob(1))
				new /obj/marker/generation/desert_wall(src)
		if(0.1 to 0.4)
			new /turf/simulated/floor/colored/sand/desert(src)
		if(0.4 to 0.41)
			new /turf/simulated/floor/desert_rock(src)
		if(0.41 to 0.43)
			interior = TRUE
			new /turf/simulated/wall/rock/desert(src)
			if(prob(1))
				new /obj/marker/generation/desert_wall(src)
		if(0.43 to 0.44)
			new /turf/simulated/floor/desert_rock(src)
		if(0.44 to 0.94)
			new /turf/simulated/floor/colored/sand/desert(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/desert_rock(src)
		if(0.95 to INFINITY)
			interior = TRUE
			new /turf/simulated/wall/rock/desert(src)
			if(prob(1))
				new /obj/marker/generation/desert_wall(src)

	if(src.loc.type == /area/)
		if(interior)
			new /area/mission/desert(src)
		else
			new /area/mission/desert/interior(src)

	. = ..()