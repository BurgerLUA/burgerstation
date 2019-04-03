/atom/movable/
	var/tmp/move_dir = 0
	var/tmp/move_delay = 0
	var/tmp/regen_delay = 0

	var/movement_delay = 4
	var/anchored = FALSE

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE | KEEP_TOGETHER

	animate_movement = SLIDE_STEPS

	var/ghost = FALSE

/atom/movable/destroy()
	var/turf/T = loc
	if(opacity && istype(T))
		T.reconsider_lights()

	. = ..()

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/handle_movement(var/adjust_delay = 0) //Runs every decisecond

	if(move_dir && move_delay <= 0)
		var/final_movement_delay = get_movement_delay()

		move_delay = round(max(final_movement_delay,move_delay + final_movement_delay),0.1)
		glide_size = step_size/move_delay

		if(Move(get_step(src,move_dir),move_dir))
			regen_delay = max(regen_delay,move_delay*2)

		return TRUE
	else
		if(adjust_delay)
			move_delay = move_delay - adjust_delay
			regen_delay = regen_delay - adjust_delay
		return FALSE

/atom/movable/proc/force_move(var/atom/new_loc)
	if(loc)
		loc.Exited(src, new_loc)

	var/atom/old_loc = loc

	loc = new_loc

	if(loc) // Moving to nullspace is a perfectly valid usage of this proc.
		loc.Entered(src, old_loc)

	for(var/atom/movable/AM in loc)
		AM.Crossed(src)

/atom/movable/Bump(var/atom/obstacle)
	return FALSE

/*
/atom/movable/proc/can_bump(var/atom/bumper)
	return FALSE
*/

/* EXAMPLE CODE
/atom/movable/Move(var/atom/new_loc,var/desired_dir=0,var/desired_step_x=0,var/desired_step_y=0)

	var/atom/old_loc = src.loc
	if(!desired_dir)
		desired_dir = get_dir(old_loc,new_loc)

	if(!new_loc)
		new_loc = get_step(src,desired_dir)

	if(!old_loc.Exit(src,desired_dir)) //Can we exit the current tile we're on?
		return FALSE

	for(var/atom/A in old_loc.contents)
		if(A.Uncross(src)) //Can we uncross this object?
			continue

		if(is_movable(A))
			var/atom/movable/M = A
			if(M.Bump(src,desired_dir))
				continue

		return FALSE

	if(!new_loc.Enter(src,desired_dir)) //Can we enter the current tile we're on?
		return FALSE

	for(var/atom/A in new_loc.contents)
		if(A.Cross(src)) //Can we cross this object?
			continue

		if(is_movable(A))
			var/atom/movable/M = A
			if(M.Bump(src,desired_dir))
				continue

		return FALSE

	step_x += desired_step_x
	step_y += desired_step_y

	old_loc.Exited()
	for(var/atom/A in old_loc.contents)
		A.Uncrossed(src)

	new_loc.Entered()
	for(var/atom/A in new_loc.contents)
		A.Crossed(src)

	return TRUE
*/

