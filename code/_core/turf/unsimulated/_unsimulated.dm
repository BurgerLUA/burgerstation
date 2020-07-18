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
		if(is_safe_to_delete(Obj) && (!SShorde || !length(SShorde.tracked_objectives) || !(Obj in SShorde.tracked_objectives)) )
			qdel(Obj)
		else
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

/turf/unsimulated/generation/proc/generate(var/size = WORLD_SIZE)
	return TRUE

/turf/unsimulated/generation/lava
	name = "lava generation"

/turf/unsimulated/generation/lava/generate(var/size = WORLD_SIZE)

	var/lava_noise = 0

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
		var/found = text2num(rustg_noise_get_at_coordinates("[1337 + i]","[x_seed]","[y_seed]"))
		lava_noise += found

	lava_noise = (lava_noise/instances) + rand(-100,100)/10000

	switch(lava_noise)
		if(-INFINITY to 0.1)
			new /turf/simulated/floor/chasm(src)
		if(0.1 to 0.2)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/basalt(src)
		if(0.2 to 0.4)
			new /turf/simulated/floor/lava(src)
			if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
		if(0.4 to 0.5)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/basalt(src)
		if(0.5 to 0.7)
			new /turf/simulated/floor/lava(src)
			if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
		if(0.7 to INFINITY)
			new /turf/simulated/wall/rock/basalt(src)

	name = "noise: [lava_noise]."

	return ..()