/obj/structure/interactive/the_curse
	name = "strange doll"
	desc = "What the fuck?"
	desc_extended = "A strange giant doll... creepy."

	icon = 'icons/mob/living/simple/the_curse.dmi'
	icon_state = "creepy"

	var/next_think = 0

	var/list/tracked_targets = list()

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	plane = PLANE_MOB
	layer = LAYER_MOB

	density = TRUE

	var/debug = FALSE

	pixel_z = 4

	anchored = FALSE

	value = 0

	size = SIZE_BOSS

/obj/structure/interactive/the_curse/debug
	debug = TRUE

/obj/structure/interactive/the_curse/Finalize()
	. = ..()
	start_advanced_thinking(src)

/proc/is_seen_by(var/atom/A,var/mob/living/L) //For SCP stuff.
	if(L.dead)
		return FALSE
	if(!L.ai && !L.client)
		return FALSE
	if((!L.client || !L.client.is_zoomed) && get_dist(A,L) > VIEW_RANGE)
		return FALSE
	if(!L.is_facing(A))
		return FALSE
	return TRUE

/obj/structure/interactive/the_curse/think()

	var/start_time = world.time

	var/list/current_viewers = list()
	var/list/current_targets = list()

	if(debug) log_subsystem("Peanut","We're going through our think loop...")
	for(var/mob/living/L in viewers(VIEW_RANGE + ZOOM_RANGE,src))
		CHECK_TICK(50,FPS_SERVER)
		if(L.dead)
			continue
		if(!L.ai && !L.client)
			continue
		tracked_targets |= L
		if(is_seen_by(src,L))
			current_viewers += L
		else
			current_targets += L

	if(!length(current_viewers))
		//No one is watching...
		if(debug) log_subsystem("Peanut","No one is watching us. Time to be alive.")
		if(!length(current_targets))
			//No one is near. Chase someone.
			if(debug) log_subsystem("Peanut","No one is near us either. Lets go find someone to kill that we know exist.")
			var/list/living_distance = list()
			for(var/k in tracked_targets)
				CHECK_TICK(75,FPS_SERVER)
				var/mob/living/L = k
				if(L.qdeleting || L.dead)
					tracked_targets -= k
					continue
				if(L.z != src.z)
					tracked_targets -= k
					continue
				var/distance = get_dist(src,L)
				if(distance >= 75) //Too far.
					tracked_targets -= L
					continue
				living_distance[L] = distance

			sortTim(living_distance,/proc/cmp_numeric_asc,associative=TRUE)

			for(var/k in living_distance)
				CHECK_TICK(75,FPS_SERVER)
				var/mob/living/L = k
				var/turf/T = get_turf(L)
				//Travel to them.
				var/list/path = burger_star(src,T,ignore_destructables=TRUE,stop_at_obstacles=list(/obj/structure/interactive/door))
				var/path_length = length(path)
				var/did_move = FALSE
				if(path_length)
					while(path_length)
						CHECK_TICK(75,FPS_SERVER)
						var/turf/last_path = get_turf(path[path_length])
						var/is_path_being_watched = FALSE
						for(var/mob/living/L2 in viewers(VIEW_RANGE*ZOOM_RANGE,last_path))
							CHECK_TICK(75,FPS_SERVER)
							if(is_seen_by(last_path,L2))
								is_path_being_watched = TRUE
								break
						if(is_path_being_watched)
							path_length -= 1
							continue
						src.force_move(last_path)
						for(var/obj/structure/interactive/door/D in range(1,src))
							if(D.door_state == DOOR_STATE_CLOSED)
								D.open()
						did_move = TRUE
						break
				else
					tracked_targets -= k //Eh whatever.
				if(did_move)
					if(debug) log_subsystem("Peanut","We've move to a safe path location.")
					break
		else
			//Murder time!
			if(debug) log_subsystem("Peanut","We have targets in view. Going to try and murder.")
			for(var/k in current_targets)
				CHECK_TICK(75,FPS_SERVER)
				var/mob/living/L = k
				var/turf/T = get_turf(L)
				var/someone_is_watching_L = FALSE
				for(var/mob/living/L2 in viewers(T,VIEW_RANGE + ZOOM_RANGE))
					CHECK_TICK(75,FPS_SERVER)
					if(is_seen_by(L,L2))
						someone_is_watching_L = TRUE
						break
				if(someone_is_watching_L)
					continue
				src.force_move(T)
				src.set_dir(L.dir)
				L.death()
				play_sound('sound/effects/neck_snap.ogg',T)
				if(debug) log_subsystem("Peanut","Found a target. We've killed them.")

		log_subsystem("Peanut","Took [world.time-start_time] deciseconds to think.")

	return TRUE
