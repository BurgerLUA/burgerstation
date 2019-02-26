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

	real_move_mod = move_mod

	if(movement_flags & MOVEMENT_RUNNING && can_sprint())
		real_move_mod += 1
	else if(movement_flags & MOVEMENT_WALKING && can_walk())
		real_move_mod -= 1

	real_move_mod = clamp(real_move_mod,0,3)

	switch(real_move_mod)
		if(1)
			. *= 1.25
		if(2)
			. *= 1
		if(3)
			. *= 0.75

	return .

/mob/Move(var/atom/new_loc,var/desired_dir=0,var/desired_step_x=0,var/desired_step_y=0)
	. = ..()
	if(.)
		switch(real_move_mod)
			if(1)
				on_walk()
			if(2)
				on_jog()
			if(3)
				on_sprint()

	return .