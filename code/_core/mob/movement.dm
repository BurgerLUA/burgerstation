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

	move_mod = Clamp(move_mod,1,3)

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

	return .