/turf/unsimulated/
	opacity = 0

	dynamic_lighting = FALSE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE
	density_up    = TRUE
	density_down  = TRUE
	allow_bullet_pass = FALSE


/turf/unsimulated/bluespace
	name = "bluespace"
	icon_state = "bluespace"

/turf/unsimulated/bluespace/Entered(atom/movable/Obj, atom/OldLoc)

	if(!istype(Obj,/mob/abstract/))
		Obj.visible_message(span("danger","\The [Obj.name] flashes violently!"))
		if(is_safe_to_delete(Obj))
			qdel(Obj)
		else if(length(rift_markers))
			Obj.force_move(get_turf(pick(rift_markers)))
			Obj.visible_message(span("danger","\The [Obj.name] appears out of nowhere!"))
		return TRUE

	return ..()

/turf/unsimulated/space
	name = "space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "1"
	opacity = 0
	var/generate = TRUE
	plane = PLANE_SPACE

/turf/unsimulated/space/is_space()
	return TRUE

/turf/unsimulated/space/Entered(atom/movable/Obj, atom/OldLoc)

	if(ismob(Obj) && !istype(Obj,/mob/abstract/))
		var/mob/M = Obj
		if(M.initialized)
			var/obj/marker/failsafe/FS = locate() in world
			if(FS)
				M.force_move(FS.loc)
			else
				M.force_move(pick(cryo_spawnpoints).loc)

	return ..()

/turf/unsimulated/space/New(var/desired_loc)
	icon_state = "space"
	return ..()

/turf/unsimulated/space/blocking
	name = "deep space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "space"
	opacity = 1
	generate = FALSE

/turf/unsimulated/abyss
	name = "abyss"
	icon = 'icons/turf/space/abyss.dmi'
	icon_state = "abyss"
	opacity = 1

/turf/unsimulated/void
	name = "abyss"
	icon = 'icons/turf/space/void.dmi'
	icon_state = "void"
	opacity = 1


/turf/unsimulated/generation
	icon = 'icons/turf/generation.dmi'

/turf/unsimulated/generation/proc/generate(var/size = WORLD_SIZE)
	return TRUE

/turf/unsimulated/generation/lava
	name = "lava generation"
	icon_state = "lava"

/turf/unsimulated/generation/lava/generate(var/size = WORLD_SIZE)

	var/noise = 0

	var/instances = 3

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
		var/found = text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[1] + i]","[x_seed]","[y_seed]"))
		noise += found

	noise = (noise/instances) + rand(-100,100)/10000

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.1)
			new /turf/simulated/hazard/lava(src)
		if(0.1 to 0.2)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/lava(src)
		if(0.2 to 0.4)
			new /turf/simulated/hazard/lava(src)
			if(prob(1))
				new /obj/marker/generation/basalt(src)
		if(0.4 to 0.6)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/mob/watcher(src)
			if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
		if(0.6 to 0.8)
			new /turf/simulated/hazard/lava(src)
			if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
		if(0.8 to INFINITY)
			new /turf/simulated/wall/rock/basalt(src)

	return ..()






/turf/unsimulated/generation/snow
	name = "snow generation"
	icon_state = "snow"

/turf/unsimulated/generation/snow/generate(var/size = WORLD_SIZE)

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
		if(-INFINITY to 0.05)
			new /turf/simulated/floor/chasm(src)
		if(0.05 to 0.1)
			new /turf/simulated/floor/basalt(src)
		if(0.1 to 0.4)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(4))
				new /obj/marker/generation/snow_grass(src)
		if(0.4 to 0.41)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.41 to 0.43)
			new /turf/simulated/wall/rock/snow(src)
		if(0.43 to 0.44)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.44 to 0.94)
			new /turf/simulated/floor/colored/snow(src)
			if(prob(0.5))
				new /obj/marker/generation/mob/snow_bear(src)
			if(prob(1))
				new /obj/marker/generation/snow_tree(src)
			if(prob(6))
				new /obj/marker/generation/snow_grass(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt/snow(src)
		if(0.95 to INFINITY)
			new /turf/simulated/wall/rock/snow(src)

	return ..()




/turf/unsimulated/generation/jungle
	name = "jungle generation"
	icon_state = "jungle"

/turf/unsimulated/generation/jungle/generate(var/size = WORLD_SIZE)

	var/noise = 0

	var/instances = 3

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

	noise = (noise/instances) + (rand(-100,100)*0.01)*0.005

	switch(noise)
		if(-INFINITY to 0.05)
			new /turf/simulated/wall/rock/basalt(src)
		if(0.05 to 0.1)
			new /turf/simulated/hazard/lava(src)
		if(0.1 to 0.11)
			new /turf/simulated/floor/basalt(src)
		if(0.11 to 0.12)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.12 to 0.13)
			new /turf/simulated/floor/colored/dirt/jungle(src)
			if(prob(0.5))
				new /obj/marker/generation/mob/arachnid(src)
		if(0.13 to 0.15)
			new /turf/simulated/floor/colored/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_rock_grass(src)
		if(0.15 to 0.4)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(2))
				new /mob/living/advanced/npc/monkey(src)
			if(prob(10))
				new /obj/marker/generation/jungle_high_grass(src)
			if(prob(3))
				new /obj/marker/generation/jungle_tree_small(src)
			if(prob(2))
				new /obj/marker/generation/jungle_tree(src)
		if(0.40 to 0.42)
			new /turf/simulated/floor/colored/dirt/jungle(src)
			if(prob(0.5))
				new /obj/marker/generation/mob/arachnid(src)
		if(0.42 to 0.43)
			new /turf/simulated/floor/colored/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_rock_grass(src)
		if(0.43 to 0.44)
			new /turf/simulated/hazard/water(src)
		if(0.4 to 0.45)
			new /turf/simulated/floor/colored/dirt/jungle(src)
			if(prob(0.5))
				new /obj/marker/generation/mob/arachnid(src)
		if(0.45 to 0.47)
			new /turf/simulated/wall/rock/brown(src)
		if(0.47 to 0.48)
			new /turf/simulated/floor/colored/dirt/jungle(src)
			if(prob(0.5))
				new /obj/marker/generation/mob/arachnid(src)
		if(0.48 to 0.75)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(2))
				new /obj/marker/generation/mob/venus_human_trap(src)
			if(prob(10))
				new /obj/marker/generation/jungle_high_grass(src)
			if(prob(3))
				new /obj/marker/generation/jungle_tree_small(src)
			if(prob(2))
				new /obj/marker/generation/jungle_tree(src)
		if(0.75 to 0.8)
			new /turf/simulated/floor/colored/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_rock_grass(src)
		if(0.8 to 0.9)
			new /turf/simulated/hazard/water(src)
		if(0.9 to INFINITY)
			new /turf/simulated/floor/colored/dirt/jungle(src)
			if(prob(0.5))
				new /obj/marker/generation/mob/arachnid(src)

	return ..()


/turf/unsimulated/generation/jungle/lz_420/generate(var/size = WORLD_SIZE)

	var/noise = 0

	var/instances = 2

	for(var/i=1,i<=instances,i++)

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

	noise = (noise/instances) + (rand(-1,1) * 0.001)

	switch(noise)
		if(-INFINITY to 0.2)
			new /turf/simulated/wall/rock/moss(src)
		if(0.2 to 0.22)
			new /turf/simulated/floor/cave_dirt(src)
		if(0.22 to 0.23)
			new /turf/simulated/floor/colored/dirt/jungle(src)
		if(0.23 to 0.48)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_high_grass(src)
			if(prob(3))
				new /obj/marker/generation/jungle_tree_small(src)
			if(prob(2))
				new /obj/marker/generation/jungle_tree(src)
		if(0.48 to 0.5)
			new /turf/simulated/floor/colored/sand/oasis(src)
		if(0.5 to 0.6)
			new /turf/simulated/hazard/water(src)
		if(0.6 to 0.62)
			new /turf/simulated/floor/colored/sand/oasis(src)
		if(0.62 to 0.8)
			new /turf/simulated/floor/grass/jungle(src)
			if(prob(10))
				new /obj/marker/generation/jungle_high_grass(src)
			if(prob(3))
				new /obj/marker/generation/jungle_tree_small(src)
			if(prob(2))
				new /obj/marker/generation/jungle_tree(src)
		if(0.8 to INFINITY)
			new /turf/simulated/wall/rock/moss(src)

	return ..()

/turf/unsimulated/generation/cave
	name = "lava generation"
	icon_state = "caves"

/turf/unsimulated/generation/cave/generate(var/size = WORLD_SIZE)

	var/noise = 0

	var/instances = 2

	for(var/i=1,i<=instances,i++) //Use sin/cosine?

		var/used_x = WRAP(x + i*WORLD_SIZE*0.25,1,255)
		var/used_y = WRAP(y + i*WORLD_SIZE*0.25,1,255)

		var/seed_resolution = WORLD_SIZE * 0.25
		var/x_seed = used_x / seed_resolution
		if(x_seed > 1)
			x_seed = 1 - (x_seed - 1)
		var/y_seed = used_y / seed_resolution
		if(y_seed > 1)
			y_seed = 1 - (y_seed - 1)
		var/found = text2num(rustg_noise_get_at_coordinates("[SSturfs.seeds[1] + i*10]","[x_seed]","[y_seed]"))
		if(found >= 0.25 && found <= 0.75) noise += found

	switch(noise)
		if(-INFINITY to 0.5)
			new /turf/simulated/floor/colored/dirt/cave(src)
			if(prob(1))
				new /obj/marker/generation/rock_wall/small(src)
		if(0.5 to 1)
			new /turf/simulated/floor/cave_dirt(src)
			if(prob(0.5))
				new /obj/marker/generation/mob/black_bear(src)
		if(1 to INFINITY)
			new /turf/simulated/wall/rock(src)

	return ..()





/turf/unsimulated/generation/forest
	name = "forest generation"
	icon_state = "forest"

/turf/unsimulated/generation/forest/generate(var/size = WORLD_SIZE)

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

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.05)
			new /turf/simulated/hazard/water(src)
		if(0.05 to 0.08)
			new /turf/simulated/floor/colored/sand/beach(src)
			if(prob(1))
				new /mob/living/simple/npc/crab(src)
		if(0.08 to 0.1)
			new /turf/simulated/floor/colored/dirt(src)
		if(0.1 to 0.42)
			new /turf/simulated/floor/colored/grass(src)
			if(prob(10))
				new /obj/marker/generation/forest_tree(src)
				if(prob(50))
					new /obj/marker/generation/mob/chicken
			if(prob(10))
				new /obj/marker/generation/forest_grass(src)
		if(0.42 to 0.44)
			new /turf/simulated/floor/colored/dirt(src)
		if(0.44 to 0.94)
			new /turf/simulated/floor/colored/grass(src)
			if(prob(5))
				new /obj/marker/generation/forest_tree(src)
			if(prob(10))
				new /obj/marker/generation/forest_grass(src)
				if(prob(5))
					new /obj/marker/generation/mob/cow(src)
		if(0.94 to 0.95)
			new /turf/simulated/floor/colored/dirt(src)
		if(0.95 to INFINITY)
			new /turf/simulated/hazard/water(src)

	return ..()