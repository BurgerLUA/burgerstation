/mob/proc/can_sprint()
	return !anchored

/mob/proc/can_walk()
	return !anchored

/mob/proc/can_jog()
	return !anchored

/mob/proc/on_sprint()
	return TRUE

/mob/proc/on_jog()
	return TRUE

/mob/proc/on_walk()
	return TRUE

/mob/handle_movement(var/adjust_delay = 1)

	if(!can_walk())
		return FALSE

	return ..()

/mob/proc/get_stance_movement_mul()

	move_mod = initial(move_mod)

	if(movement_flags & MOVEMENT_RUNNING && can_sprint())
		move_mod += 10 //Arbitrary. Clamped later.
	else if(movement_flags & MOVEMENT_WALKING && can_walk())
		move_mod -= 10 //Arbitrary. Clamped later.

	move_mod += move_mod_button

	move_mod = clamp(move_mod,1,3)

	switch(move_mod)
		if(1)
			return walk_delay_mul
		if(2)
			return jog_delay_mul
		if(3)
			return sprint_delay_mul

	return 1

/mob/get_movement_delay()
	. = ..()
	. *= get_stance_movement_mul()

/mob/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	. = ..()

	if(.)
		switch(move_mod)
			if(1)
				on_walk()
			if(2)
				on_jog()
			if(3)
				on_sprint()


/mob/get_max_acceleration_value()
	if(move_mod >= 3)
		return 100
	if(move_mod >= 2)
		return 75
	if(move_mod >= 1)
		return 50
	return 25

/mob/proc/update_rs_chat()
	for(var/k in stored_chat_text)
		var/obj/effect/chat_text/CT = k
		CT.glide_size = src.glide_size
		CT.force_move(src.loc)

/mob/proc/update_z_position()

	if(!ckey_last)
		if(last_z) all_mobs_with_clients_by_z["[last_z]"] -= src
		return FALSE

	var/turf/T = get_turf(src)

	if((!T || last_z != T.z))
		if(last_z && all_mobs_with_clients_by_z["[last_z]"])
			all_mobs_with_clients_by_z["[last_z]"] -= src
		if(T && T.z)
			last_z = T.z
			if(!all_mobs_with_clients_by_z["[last_z]"])
				all_mobs_with_clients_by_z["[last_z]"] = list()
			all_mobs_with_clients_by_z["[last_z]"] += src
		else
			last_z = 0

	return TRUE

/mob/post_move(var/atom/old_loc)

	. = ..()

	if(client)
		client.post_move(loc,old_loc)

	if(loc && src.ckey_last)
		var/turf/T = get_turf(src)
		if(T)
			var/map_file = SSdmm_suite.z_level_to_file[T.z]
			if(!map_file)
				log_error("Error: Could not find valid map file for z level [T.z]!")
			else
				var/parallax_file = SSdmm_suite.map_to_parallax[map_file]
				if(!parallax_file)
					for(var/k in src.parallax)
						var/obj/parallax/P = src.parallax[k]
						P.alpha = 0
						//P.screen_loc = "CENTER,CENTER"
				else
					for(var/k in src.parallax)
						var/obj/parallax/P = src.parallax[k]
						P.icon = parallax_file
						P.alpha = initial(P.alpha)
						var/desired_x = FLOOR(-(src.x - (WORLD_SIZE*0.5)) * P.ratio,1)
						var/desired_y = FLOOR(-(src.y - (WORLD_SIZE*0.5)) * P.ratio,1)
						P.screen_loc = "CENTER-7:[desired_x],CENTER-7:[desired_y]"

	update_rs_chat()

	update_z_position()

	if(move_dir && observing)
		observing.observers -= src
		observing = null

	for(var/k in observers)
		var/mob/chosenObserver = k
		if(chosenObserver.observing != src)
			log_error("Warning: it was said that an observer was observing, but they actually weren't.")
			observers -= k
			continue
		chosenObserver.glide_size = glide_size
		chosenObserver.force_move(get_turf(loc))

	close_turf_contents()

	if(client && invisibility < INVISIBLITY_GHOST)
		var/area/new_area = loc ? get_area(loc) : null
		var/area/old_area = old_loc ? get_area(old_loc) : null
		if(!new_area || !new_area.ambient_sound)
			stop_ambient_sounds(src)

		if(new_area)
			if(new_area.ambient_sound && (!old_area || old_area.ambient_sound != new_area.ambient_sound))
				play_ambient_sound(new_area.ambient_sound,list(src),environment = new_area.sound_environment,loop = TRUE)
			if(CONFIG("ENABLE_AREA_TRACKS",FALSE) && length(new_area.tracks) && (!client.next_music_track || client.next_music_track <= world.time))
				play_music_track(pick(new_area.tracks),client)

/mob/set_dir(var/desired_dir,var/force=FALSE)

	if(!force && client && client.is_zoomed)
		desired_dir = client.is_zoomed

	. = ..()
