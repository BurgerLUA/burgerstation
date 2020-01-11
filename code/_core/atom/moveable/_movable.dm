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

	var/change_dir_on_move = FALSE

	var/mob/living/grabber

	var/allow_shuttle_move = TRUE

/atom/movable/proc/can_be_grabbed(var/atom/grabber)
	return !anchored

/atom/movable/Initialize()
	. = ..()
	if(loc)
		area = get_area(src)
		area.Entered(src,null)
	return .

/atom/movable/Destroy()
	area = null
	grabber = null
	force_move(null)
	return ..()

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/handle_movement(var/adjust_delay = 1) //Measured in ticks.

	if(move_dir && move_delay <= 0)
		var/final_movement_delay = get_movement_delay()
		move_delay = round(max(final_movement_delay,move_delay + final_movement_delay), adjust_delay ? adjust_delay : 1) //Round to the nearest tick. Counting decimal ticks is dumb.
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

	if(loc)
		loc.Exited(src, new_loc)

	var/atom/old_loc = loc

	loc = new_loc

	if(loc)
		loc.Entered(src, old_loc)
		for(var/atom/movable/AM in loc.contents)
			if(AM == src)
				continue
			AM.Crossed(src)

	return TRUE

/atom/movable/Bump(var/atom/obstacle,var/Dir=0)

	if(Dir && is_movable(obstacle))
		var/atom/movable/M = obstacle
		if(!M.anchored && !M.grabber)
			M.move_delay = src.move_delay
			M.glide_size = src.glide_size

			M.Move(get_step(M,Dir),Dir)
			return TRUE

	return FALSE

/atom/movable/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0)

	if(change_dir_on_move && Dir)
		set_dir(Dir)

	if(!NewLoc)
		return FALSE

	if(!loc)
		return FALSE

	var/atom/OldLoc = loc

	if(!OldLoc.Exit(src,NewLoc))
		Bump(OldLoc,Dir)
		return FALSE

	for(var/atom/movable/M in OldLoc.contents)
		if(M == src)
			continue
		if(!M.Uncross(src,NewLoc,OldLoc))
			Bump(M,Dir)
			return FALSE

	if(!NewLoc.Enter(src,OldLoc))
		Bump(NewLoc,Dir)
		return FALSE

	for(var/atom/movable/M in NewLoc.contents)
		if(M == src)
			continue
		if(!M.Cross(src,NewLoc,OldLoc))
			Bump(M,Dir)
			return FALSE

	OldLoc.Exited(src,NewLoc)
	for(var/atom/A in OldLoc.contents)
		if(A == src)
			continue
		A.Uncrossed(src,NewLoc,OldLoc)

	NewLoc.Entered(src,OldLoc)
	for(var/atom/A in NewLoc.contents)
		if(A == src)
			continue
		A.Crossed(src,NewLoc,OldLoc)

	step_x += desired_step_x
	step_y += desired_step_y
	loc = NewLoc

	return TRUE
