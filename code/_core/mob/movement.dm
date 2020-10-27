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
			.return walk_delay_mul
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

	return .

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

	return .


/mob/proc/update_rs_chat()
	for(var/k in stored_chat_text)
		var/obj/effect/chat_text/CT = k
		CT.glide_size = src.glide_size
		CT.force_move(src.loc)


/mob/post_move(var/atom/old_loc)

	var/turf/T = get_turf(src.loc)

	for(var/k in parallax)
		var/obj/parallax/P = parallax[k]
		var/desired_x = FLOOR(-(T.x - (WORLD_SIZE*0.5)) * P.ratio,1)
		var/desired_y = FLOOR(-(T.y - (WORLD_SIZE*0.5)) * P.ratio,1)
		P.screen_loc = "CENTER-7:[desired_x],CENTER-7:[desired_y]"

	. = ..()

	if(client)
		client.post_move(loc,old_loc)

	update_rs_chat()

	return .