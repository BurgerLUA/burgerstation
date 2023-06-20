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

	plane = PLANE_MOVABLE
	layer = LAYER_MOB

	density = TRUE

	var/debug = FALSE

	pixel_z = 4

	anchored = FALSE

	value = 0

	size = SIZE_BOSS

/obj/structure/interactive/the_curse/Destroy()
	tracked_targets?.Cut()
	. = ..()

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
	if(!is_facing(L,A))
		return FALSE
	return TRUE

/obj/structure/interactive/the_curse/think()

	var/start_time = true_time()

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
		else if(get_dist(L,src) <= 1)
			current_targets += L

	if(!length(current_viewers))
		//No one is watching...
		if(debug) log_subsystem("Peanut","No one is watching us. Time to be alive.")
		if(length(current_targets)) //Murder time!
			if(debug) log_subsystem("Peanut","We have targets in view. Going to try and murder.")
			for(var/k in current_targets)
				CHECK_TICK(75,FPS_SERVER)
				var/mob/living/L = k
				if(get_dist(src,L) > 1) //Failsafe
					continue
				var/turf/T = get_turf(L)
				var/someone_is_watching_L = FALSE
				for(var/mob/living/L2 in viewers(T,VIEW_RANGE + ZOOM_RANGE))
					CHECK_TICK(75,FPS_SERVER)
					if(is_seen_by(L,L2))
						someone_is_watching_L = TRUE
						break
				if(someone_is_watching_L)
					continue
				src.set_dir(get_dir(src,L))
				L.death()
				play_sound('sound/effects/neck_snap.ogg',T)
				if(debug) log_subsystem("Peanut","Found a target. We've killed them.")
				break
		else
			//No one is near. Chase someone.
			if(debug) log_subsystem("Peanut","No one is near us either. Lets go find someone to kill that we know exist.")
			var/list/best_path
			var/best_path_was_interupted = FALSE
			for(var/k in tracked_targets)
				var/mob/living/L = k
				if(!L || L.qdeleting || L.dead)
					tracked_targets -= k
					continue
				if(L.z != src.z)
					tracked_targets -= k
					continue
				var/distance = get_dist(src,L)
				if(distance >= 128) //Too far.
					tracked_targets -= L
					continue
				var/turf/T = get_turf(L)
				//Travel to them.
				var/turf/start_turf = get_turf(src)
				var/list/path = AStar_Circle(start_turf,T,src)
				if(path) path -= start_turf
				if(debug) log_subsystem("Peanut","Trying to go kill [L]... initial path length returned [length(path)].")
				var/path_length = length(path)
				var/was_interupted = FALSE
				if(!path_length)
					continue
				if(path_length > 10) //Limit to 10 tiles per think.
					path.Cut(11,0)
					was_interupted = TRUE
					path_length = 10
				for(var/i=1,i<=path_length,i++)
					CHECK_TICK(75,FPS_SERVER)
					var/turf/PT = path[i]
					var/is_turf_being_watched = FALSE
					for(var/mob/living/L2 in viewers(VIEW_RANGE*ZOOM_RANGE,PT))
						CHECK_TICK(75,FPS_SERVER)
						if(is_seen_by(PT,L2))
							is_turf_being_watched = TRUE
							break
					if(is_turf_being_watched)
						path.Cut(i,0)
						was_interupted = TRUE
						break
					var/obj/structure/interactive/door/D = locate() in PT.contents
					if(D && D.door_state != DOOR_STATE_OPENED)
						path.Cut(i,0)
						was_interupted = TRUE
						break
				if(!length(path))
					continue
				if(!best_path || (length(best_path) > length(path) && (best_path_was_interupted || !was_interupted)))
					best_path = path
					best_path_was_interupted = was_interupted
			if(best_path)
				if(debug) log_subsystem("Found a path to move to. Moving...")
				var/turf/path_ending = best_path[length(best_path)]
				src.force_move(path_ending)
				for(var/obj/structure/interactive/door/D in range(src,1))
					if(D.door_state == DOOR_STATE_BROKEN)
						D.on_destruction()
					else if(D.door_state != DOOR_STATE_OPENED)
						D.open()
			else
				if(debug) log_subsystem("Peanut","Could not find a valid path to a tracked target.")

		if(debug) log_subsystem("Peanut","Took [true_time()-start_time] deciseconds to think.")

	return TRUE
