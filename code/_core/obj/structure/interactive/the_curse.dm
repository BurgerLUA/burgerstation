/obj/structure/interactive/the_curse
	name = "strange doll"
	desc = "What the fuck?"
	desc_extended = "A strange giant doll... creepy."

	icon = 'icons/mob/living/simple/the_curse.dmi'
	icon_state = "creepy"

	var/next_think = 0

	var/list/tracked_viewers = list()

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	plane = PLANE_MOB
	layer = LAYER_MOB

	var/frustration = 0

	density = TRUE

	var/debug = FALSE

	pixel_z = 4

	anchored = FALSE

/obj/structure/interactive/the_curse/spawn_chance/Finalize()
	. = ..()
	if(prob(90))
		qdel(src)

/obj/structure/interactive/the_curse/debug
	debug = TRUE

/obj/structure/interactive/the_curse/Finalize()
	. = ..()
	start_thinking(src)


/obj/structure/interactive/the_curse/proc/is_seen_by(var/atom/A,var/mob/living/L)
	if(L.dead)
		return FALSE
	if(!L.ai && !L.client)
		return FALSE
	if((!L.client || !L.client.is_zoomed) && get_dist(A,L) > VIEW_RANGE)
		return FALSE
	if(!L.is_facing(A))
		return FALSE

	return TRUE

/obj/structure/interactive/the_curse/post_move(var/atom/old_loc)

	. = ..()

	frustration = 0

/obj/structure/interactive/the_curse/think()

	if(next_think <= world.time)

		var/list/current_viewers = list()
		for(var/mob/living/L in viewers(VIEW_RANGE + ZOOM_RANGE,src))
			if(!is_seen_by(src,L))
				continue
			tracked_viewers |= L
			current_viewers |= L
			if(debug) log_debug("[L.get_debug_name()] is watching us.")

		if(!length(current_viewers) && length(tracked_viewers))
			var/mob/living/L = tracked_viewers[1] //We want our first viewer...
			if(debug) log_debug("Trying to hunt [L.get_debug_name()]...")
			if(L.dead || L.qdeleting)
				if(debug) log_debug("Can't hunt them. They're dead or deleting.")
				tracked_viewers -= L
			else if(L.ckey_last && (!L.client || L.client.inactivity >= SECONDS_TO_DECISECONDS(30)))
				if(debug) log_debug("Can't hunt them. They're SSD.")
				tracked_viewers -= L
			else
				if(src.z == L.z && get_dist(src,L) <= VIEW_RANGE*0.5) //Go in for the kill...
					if(debug) log_debug("We want to go in for the kill...")
					var/turf/T = get_turf(L)
					var/is_valid_turf = TRUE
					for(var/mob/living/L2 in oviewers(VIEW_RANGE,L)) //Is anyone watching our target?
						if(!is_seen_by(L,L2))
							continue
						is_valid_turf = FALSE //Can't kill because people are watching L
						if(debug) log_debug("Can't go in for the kill, [L2.get_debug_name()] is watching!")
						break
					if(is_valid_turf)
						src.force_move(T)
						src.set_dir(L.dir)
						L.death()
						play_sound('sound/effects/neck_snap.ogg',T)
						if(debug) log_debug("Nothing personell kid.")
					else
						if(debug) log_debug("We can't kill them. This is frustrating.")
						frustration += 1
				else //We're too far, we should teleport.
					if(debug) log_debug("We're too far away from our target. We need to get closer...")
					var/turf/found_turf
					for(var/turf/T in oview(VIEW_RANGE,L)) //Lets teleport...
						if(debug) log_debug("Checking to see if we can teleport to [T.get_debug_name()]...")
						if(!T.is_safe_teleport())
							if(debug) log_debug("Nope. This turf is unsafe.")
							continue
						var/is_valid_turf = TRUE
						for(var/mob/living/L2 in viewers(VIEW_RANGE,T)) //Is anyone watching the turf we we want to teleport on??
							if(!is_seen_by(T,L2))
								continue
							is_valid_turf = FALSE //Can't teleport because people are watching the turf.
							if(debug) log_debug("Nope. This is being watched by [L2.get_debug_name()].")
							break
						if(is_valid_turf)
							found_turf = T
							break
					if(found_turf)
						if(debug) log_debug("We found a safe turf. Time to teleport!")
						src.force_move(found_turf)
						src.face_atom(L)
					else
						if(debug) log_debug("Can't find a suitable turf. This is frustrating.")
						frustration += 1
				if(frustration >= 3)
					tracked_viewers -= L
					tracked_viewers |= L //Move them at the back of the line.
					frustration = 0
					if(debug) log_debug("I'm frustrated at hunting [L.get_debug_name()]. Lets find someone else.")

		next_think = world.time + SECONDS_TO_DECISECONDS(2)

	. = ..()