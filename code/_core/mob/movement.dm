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
		move_mod += 10
	else if(movement_flags & MOVEMENT_WALKING && can_walk())
		move_mod -= 1

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

	if(health && health.health_max)
		. *= 2 - (health.health_current/health.health_max)


/mob/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	var/atom/old_loc = loc

	. = ..()

	if(.)
		switch(move_mod)
			if(1)
				on_walk()
			if(2)
				on_jog()
			if(3)
				on_sprint()

		if(loc != old_loc)
			post_move(old_loc)

	if(move_dir && observed)
		observed.observers -= src
		observed = null

/mob/proc/update_rs_chat()
	for(var/k in stored_chat_text)
		var/obj/effect/chat_text/CT = k
		CT.glide_size = src.glide_size
		CT.force_move(src.loc)


/mob/proc/update_parallax()

	if(!ckey_last)
		return FALSE

	var/turf/T = get_turf(src.loc)

	for(var/k in parallax)
		var/obj/parallax/P = parallax[k]
		var/desired_x = FLOOR(-(T.x - (WORLD_SIZE*0.5)) * P.ratio,1)
		var/desired_y = FLOOR(-(T.y - (WORLD_SIZE*0.5)) * P.ratio,1)
		P.screen_loc = "CENTER-7:[desired_x],CENTER-7:[desired_y]"

	return TRUE

/mob/proc/update_z_position()

	if(!ckey_last)
		return FALSE

	var/turf/T = get_turf(src)

	if((!T || last_z != T.z))
		if(last_z && all_mobs_with_clients_by_z["[last_z]"])
			all_mobs_with_clients_by_z["[last_z]"] -= src
		if(T && T.z)
			last_z = T.z
			if(!all_mobs_with_clients_by_z["[last_z]"])
				all_mobs_with_clients_by_z["[last_z]"] = list()
			all_mobs_with_clients_by_z["[last_z]"] |= src
		else
			last_z = 0

	return TRUE


/mob/post_move(var/atom/old_loc)

	update_parallax()

	. = ..()

	if(client)
		client.post_move(loc,old_loc)

	update_rs_chat()

	update_z_position()

	for(var/k in observers)
		var/mob/chosenObserver = k
		chosenObserver.glide_size = glide_size
		chosenObserver.force_move(get_turf(loc))

/mob/set_dir(var/desired_dir,var/force=FALSE)

	if(client && client.is_zoomed)
		desired_dir = client.is_zoomed
		return ..()

	if(attack_flags & CONTROL_MOD_BLOCK)
		return FALSE

	. = ..()
