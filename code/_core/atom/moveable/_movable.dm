/atom/movable/

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE | PIXEL_SCALE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	animate_movement = SLIDE_STEPS

	var/area/area //The object's area.

	var/tmp/move_dir = 0
	var/tmp/move_delay = 0

	var/movement_delay = 4 //Measured in ticks.
	var/anchored = FALSE
	var/ghost = FALSE

	var/damage_type_thrown = "thrown" //Damage type if the object is thrown. If none is provided, it will just use damage_type and double the damage.

/atom/movable/Initialize()
	. = ..()
	area = get_area(src) //TODO: Is this needed?
	return .

/atom/movable/destroy()
	loc = null
	return ..()

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/handle_movement(var/adjust_delay = 1) //Measured in ticks.

	if(move_dir && move_delay <= 0)
		var/final_movement_delay = get_movement_delay()

		move_delay = floor(max(final_movement_delay,move_delay + final_movement_delay), adjust_delay ? adjust_delay : 1) //Round to the nearest tick. Counting decimal ticks is dumb.
		glide_size = step_size/move_delay

		var/move_result = Move(get_step(src,move_dir),move_dir)

		if(move_result == 0 && (move_dir in DIRECTIONS_INTERCARDINAL))
			for(var/new_dir in DIRECTIONS_CARDINAL)
				if((new_dir & move_dir) && Move(get_step(src,new_dir),new_dir))
					return TRUE

		return TRUE
	else
		if(adjust_delay)
			move_delay = move_delay - adjust_delay
		return FALSE

/atom/movable/proc/force_move(var/atom/new_loc)

	// Moving to nullspace is a perfectly valid usage of this proc.

	if(loc)
		loc.Exited(src, new_loc)

	var/atom/old_loc = loc

	loc = new_loc

	if(loc)
		loc.Entered(src, old_loc)

	for(var/atom/movable/AM in loc)
		AM.Crossed(src)

	return TRUE

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

