/turf/unsimulated/generation/forest
	name = "forest generation"
	icon_state = "forest"

/turf/unsimulated/generation/forest/path/
	icon_state = "forest_path"
	density = FALSE

/turf/unsimulated/generation/forest/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/colored/dirt/path(src)
		if(src.loc.type == /area/) new /area/mission/forest(src)
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
	noise += (x/world.maxx + y/world.maxy)/2 - 0.5


	var/place_grass = TRUE //Allow placement of tall grass or flowers.
	var/place_ground = TRUE //Allow placement of ground turfs.

	if(noise <= 40) //Forest half.
		if(prob(10))
			new /obj/marker/generation/foliage/tree(src)
			if(prob(10))
				new /obj/marker/generation/forest_dirt(src)
				new /turf/simulated/floor/colored/dirt(src)
				place_ground = FALSE
				place_grass = FALSE
		else if(prob(2))
			var/atom/chosen_bush = pick(/obj/marker/generation/foliage/bushes/leafy,/obj/marker/generation/foliage/bushes/stalk)
			new chosen_bush(src)
	else //Grass half. Less trees.
		if(prob(1))
			new /obj/marker/generation/foliage/tree(src)
			if(prob(1))
				new /obj/marker/generation/forest_dirt(src)
				new /turf/simulated/floor/colored/dirt(src)
				place_ground = FALSE
				place_grass = FALSE
		else if(prob(2))
			place_grass = FALSE
			new /obj/marker/generation/plant/wheat(src)
		else if(prob(3))
			var/atom/chosen_bush = pick(/obj/marker/generation/foliage/bushes/generic,/obj/marker/generation/foliage/bushes/grass,/obj/marker/generation/foliage/bushes/sun)
			new chosen_bush(src)
			place_grass = FALSE

	if(place_grass)
		if(prob(2))
			new /obj/marker/generation/foliage/flowers(src)
		else if(prob(2))
			new /obj/marker/generation/foliage/flowers/lavender(src)
		else if(prob(10))
			new /obj/marker/generation/foliage/grass(src)

	if(place_ground)
		new /turf/simulated/floor/colored/grass(src)
		color = blend_colors("#336D31","#426D31",noise)
		if(prob(1))
			new /obj/marker/generation/forest_soil(src)

	if(src.loc.type == /area/) new /area/mission/forest(src)

	return ..()