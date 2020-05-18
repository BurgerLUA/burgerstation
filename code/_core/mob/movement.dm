/mob/proc/can_sprint()
	return TRUE

/mob/proc/on_sprint()
	return TRUE

/mob/proc/on_jog()
	return TRUE

/mob/proc/can_walk()
	return TRUE

/mob/proc/can_jog()
	return TRUE

/mob/proc/on_walk()
	return TRUE

/mob/get_movement_delay()

	. = ..()

	move_mod = initial(move_mod)

	if(movement_flags & MOVEMENT_RUNNING && can_sprint())
		move_mod += 10
	else if(movement_flags & MOVEMENT_WALKING && can_walk())
		move_mod -= 1

	move_mod += move_mod_button

	move_mod = clamp(move_mod,1,3)

	switch(move_mod)
		if(1)
			. *= walk_delay_mul
		if(2)
			. *= jog_delay_mul
		if(3)
			. *= sprint_delay_mul

	if(health && health.health_max)
		. *= 2 - (health.health_current/health.health_max)

	return .

/mob/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)

	var/atom/old_loc = loc

	. = ..()

	if(.)

		update_rs_chat()

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
	for(var/obj/effect/chat_text/CT in stored_chat_text)
		CT.glide_size = src.glide_size
		CT.force_move(src.loc)


/mob/post_move(var/atom/old_loc)

	for(var/k in parallax)
		var/obj/parallax/P = parallax[k]
		var/desired_x = FLOOR(-(x - (WORLD_SIZE*0.5)) * P.ratio,1)
		var/desired_y = FLOOR(-(y - (WORLD_SIZE*0.5)) * P.ratio,1)
		P.screen_loc = "CENTER-7:[desired_x],CENTER-7:[desired_y]"

	. = ..()

	if(client)
		client.post_move(loc,old_loc)

	return .