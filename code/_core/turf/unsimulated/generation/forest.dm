/turf/unsimulated/generation/forest
	name = "forest generation"
	icon_state = "forest"
	var/path_only = FALSE

/turf/unsimulated/generation/forest/generate(var/size = WORLD_SIZE)

	var/shitfix = path_only

	if(no_wall)
		new /turf/simulated/floor/colored/grass(src)
		if(src.loc.type == /area/) new /area/dungeon/z_01/forest(src)
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

	var/place_grass = TRUE
	var/place_ground = TRUE
	if(noise <= 40)
		if(!path_only && prob(10))
			new /obj/marker/generation/foliage/tree(src)
			place_grass = FALSE
			if(prob(40))
				new /obj/marker/generation/forest_dirt(src)
				place_ground = FALSE
		else if(!path_only && prob(2))
			var/list/valid_bushes = list(
				/obj/marker/generation/foliage/bushes/leafy,
				/obj/marker/generation/foliage/bushes/stalk
			)
			var/atom/chosen_bush = pick(valid_bushes)
			new chosen_bush(src)
			place_grass = FALSE
		else
			if(!path_only && prob(0.2))
				new /obj/marker/generation/mob/black_bear(src)
			if(!path_only && prob(0.2))
				new /obj/marker/generation/plant/tomato(src)
				if(prob(1))
					new /obj/marker/generation/mob/goat(src)
				place_grass = FALSE
			else if(!path_only && prob(1))
				new /obj/marker/generation/plant/chanterelle(src)
				place_grass = FALSE
	else
		if(!path_only && prob(1))
			new /obj/marker/generation/foliage/tree(src)
			place_grass = FALSE
			if(prob(1))
				new /obj/marker/generation/forest_dirt(src)
				place_ground = FALSE
				new /turf/simulated/floor/colored/dirt(src)
				if(src.loc.type == /area/) new /area/dungeon/z_01/forest(src)

		else if(!path_only && prob(5))
			place_grass = FALSE
			new /obj/marker/generation/plant/wheat(src)
			if(prob(2))
				new /obj/marker/generation/mob/chicken(src)
		else if(!path_only && prob(3))
			if(prob(1))
				new /obj/marker/generation/mob/mouse/brown(src)
			var/list/valid_bushes = list(
				/obj/marker/generation/foliage/bushes/generic,
				/obj/marker/generation/foliage/bushes/grass,
				/obj/marker/generation/foliage/bushes/sun
			)
			var/atom/chosen_bush = pick(valid_bushes)
			new chosen_bush(src)
			place_grass = FALSE

	if(place_grass)
		if(prob(2))
			new /obj/marker/generation/foliage/flowers(src)
			if(prob(1))
				new /obj/marker/generation/mob/bee(src)
		if(prob(2))
			new /obj/marker/generation/foliage/flowers/lavender(src)
		else if(prob(10))
			new /obj/marker/generation/foliage/grass(src)
			if(prob(1))
				if(prob(10))
					new /mob/living/simple/bull(src)
				else
					new /obj/marker/generation/mob/cow(src)


	if(place_ground)
		new /turf/simulated/floor/colored/grass(src)
		if(src.loc.type == /area/) new /area/dungeon/z_01/forest(src)
		color = blend_colors("#336D31","#426D31",noise)
		if(prob(1))
			new /obj/marker/generation/forest_soil(src)

	if(shitfix)
		disallow_generation = TRUE

	if(prob(0.5))
		new /obj/marker/generation/mob/syndicate(src)

	return ..()


/turf/unsimulated/generation/forest/path/
	name = "forest generation - path"
	icon_state = "forest_path"
	path_only = TRUE