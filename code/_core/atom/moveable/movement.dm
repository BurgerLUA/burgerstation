/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/can_enter(var/turf/T)

	if(!T.Enter(src,src.loc))
		return FALSE

	for(var/k in T.contents)
		var/atom/movable/M = k
		if(M.density && !M.Cross(src))
			return FALSE

	return TRUE


/atom/movable/proc/handle_movement(var/adjust_delay = 1) //Measured in ticks

	if(anchored)
		return FALSE

	var/final_move_dir = move_dir

	//Handle acceleration and deceleration
	if(!final_move_dir)
		if(deceleration)
			acceleration_value = round(max(acceleration_value - deceleration*adjust_delay,0),0.01)
		else
			acceleration_value = 0
		if(use_momentum && move_dir_last && acceleration_value)
			final_move_dir = move_dir_last
	else
		final_move_dir = sanitize_direction(final_move_dir)

	//Now we move.
	if(final_move_dir && move_delay <= 0 && is_valid_dir(final_move_dir))

		var/final_movement_delay = max(adjust_delay,get_movement_delay())
		var/intercardinal = is_intercardinal_dir(final_move_dir)

		if(intercardinal)
			final_movement_delay *= HYPOTENUSE(1,1)

		if(acceleration_mod > 0)
			final_movement_delay *= 1 / (acceleration_mod + ((acceleration_value/100)*(1-acceleration_mod)))

		if(isturf(loc))
			var/turf/T = loc
			final_movement_delay *= T.delay_modifier

		move_delay = CEILING(max(final_movement_delay,move_delay + final_movement_delay), adjust_delay ? adjust_delay : 1) //Round to the nearest tick. Counting decimal ticks is dumb.

		glide_size = move_delay ? step_size/move_delay : 1

		//Handling intercardinal collisions.
		if(intercardinal)
			var/first_move_dir_to_use = first_move_dir ? first_move_dir : get_true_4dir(final_move_dir)
			var/second_move_dir_to_use = final_move_dir & ~first_move_dir_to_use
			var/turf/first_step = get_step(src,first_move_dir_to_use)
			var/turf/second_step = get_step(src,second_move_dir_to_use)
			if(!first_step || !src.can_enter(first_step))
				final_move_dir &= ~first_move_dir_to_use
			if(!second_step || !src.can_enter(second_step))
				final_move_dir &= ~second_move_dir_to_use

		//Storing previous move dir and handling inability to move.
		var/similiar_move_dir = FALSE
		var/turf/step = final_move_dir ? get_step(src,final_move_dir) : null
		if(step && Move(step,final_move_dir))
			if(move_dir_last & final_move_dir)
				similiar_move_dir = TRUE
			move_dir_last = final_move_dir
			is_moving = TRUE
		else
			move_dir_last = 0x0
			move_delay = max(move_delay,DECISECONDS_TO_TICKS(2))
			is_moving = FALSE

		if(acceleration_mod)
			if(similiar_move_dir)
				acceleration_value = round(min(acceleration_value + acceleration*adjust_delay,100),0.01)
			else
				acceleration_value *= 0.5

	if(move_delay < 0)
		is_moving = FALSE

	if(adjust_delay)
		move_delay = move_delay - adjust_delay

	return FALSE

/atom/movable/proc/force_move(var/atom/new_loc)

	var/atom/old_loc = loc

	if(old_loc)
		old_loc.Exited(src, new_loc)
		if(old_loc && src.density)
			for(var/k in old_loc.contents)
				var/atom/movable/M = k
				if(M == src)
					continue
				if(!M.density)
					continue
				M.Uncrossed(src)

	loc = new_loc

	if(new_loc)
		new_loc.Entered(src, old_loc)
		if(new_loc && src.density)
			for(var/k in new_loc.contents)
				var/atom/movable/M = k
				if(M == src)
					continue
				if(!M.density)
					continue
				M.Crossed(src)

	if(old_loc != loc)
		post_move(old_loc)

	return TRUE

/atom/movable/proc/post_move(var/atom/old_loc)

	if(grabbing_hand)
		grabbing_hand.check_grab()

	var/light_source/L
	var/thing
	for(thing in light_sources)
		L = thing
		L.source_atom.update_light()

	HOOK_CALL("post_move")
	return TRUE

/atom/movable/Bump(atom/Obstacle)

	if(ismovable(Obstacle) && src.loc != Obstacle)
		var/atom/movable/M = Obstacle
		if(!M.anchored && (!grabbing_hand || Obstacle != grabbing_hand.owner))
			M.glide_size = src.glide_size
			return M.Move(get_step(M,get_dir(src,Obstacle)))

	return FALSE



/atom/movable/Move(var/atom/NewLoc,var/Dir=0x0,var/step_x=0,var/step_y=0)

	var/atom/OldLoc = loc

	if(!NewLoc || NewLoc == OldLoc)
		return FALSE

	//var/move_direction = get_dir(OldLoc,NewLoc)

	if(change_dir_on_move && Dir)
		set_dir(Dir)

	//Try: Enter the new turf.
	if(src.density && !NewLoc.Enter(src,OldLoc) && !src.Bump(NewLoc))
		return FALSE

	//Try: Exit the old turf.
	if(src.density && OldLoc && !OldLoc.Exit(src,NewLoc))
		return FALSE

	//Try: Cross the Contents
	if(src.density)
		for(var/k in NewLoc.contents)
			CHECK_TICK(100,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(M.density && !M.Cross(src) && !src.Bump(M))
				return FALSE

	//Try: Uncross the Contents
	if(src.density && OldLoc)
		for(var/k in OldLoc.contents)
			CHECK_TICK(100,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(M.density && !M.Uncross(src))
				return FALSE

	//Do: Enter the turf.
	if(src.density) NewLoc.Entered(src,OldLoc)

	//Do: Exit the turf.
	if(src.density) NewLoc.Exited(src,NewLoc)

	if(!OldLoc || OldLoc == loc)
		loc = NewLoc

	//Do: Crossed the contents
	if(src.density)
		for(var/k in NewLoc.contents)
			CHECK_TICK(100,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(!M.density)
				continue
			M.Crossed(src)

	//Do: Uncrossed the contents
	if(src.density && OldLoc)
		for(var/k in OldLoc.contents)
			CHECK_TICK(100,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(!M.density)
				continue
			M.Uncrossed(src)

	post_move(OldLoc)

	return TRUE




