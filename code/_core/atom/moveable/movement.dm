/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/can_enter(var/turf/T,var/loc_overide = src.loc)

	if(!T.Enter(src,loc_overide))
		return FALSE

	for(var/k in T.contents)
		var/atom/movable/M = k
		if(M.density && !M.Cross(src,loc_overide))
			return FALSE

	return TRUE


/atom/movable/proc/handle_movement(var/adjust_delay = 1) //Measured in ticks

	if(anchored || CALLBACK_EXISTS("momentum_\ref[src]"))
		is_moving = FALSE
		return FALSE

	var/final_move_dir = move_dir

	if(!move_dir && use_momentum && move_dir_last && acceleration_value > 0)
		final_move_dir = move_dir_last

	if(final_move_dir && move_delay <= 0 && is_valid_dir(final_move_dir))

		var/final_movement_delay = get_movement_delay()
		var/intercardinal = is_intercardinal_dir(final_move_dir)

		if(intercardinal)
			final_movement_delay *= HYPOTENUSE(1,1)

		if(isturf(loc) && (collision_flags & FLAG_COLLISION_WALKING))
			var/turf/T = loc
			final_movement_delay *= T.move_delay_modifier

		var/final_movement_delay_before_accel = final_movement_delay
		if(acceleration_mod > 0)
			var/accel_decimal = 1 - clamp(acceleration_value/100,0,1)
			final_movement_delay *= 1 + (accel_decimal*acceleration_mod)

		move_delay = max(move_delay,0)
		move_delay += CEILING(final_movement_delay, adjust_delay) //Round to the nearest tick.

		glide_size = move_delay ? CEILING(step_size/move_delay,0.01) : 1
		glide_size = max(glide_size,FPS_CLIENT/FPS_SERVER)

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
			var/first_max_value = get_max_acceleration_value()
			if(similiar_move_dir && final_movement_delay_before_accel)
				acceleration_value += 1 + acceleration*adjust_delay*(final_movement_delay_before_accel/final_movement_delay)
				acceleration_value = min(first_max_value,acceleration_value)
			else
				acceleration_value *= 0.5
			if(acceleration_value > first_max_value)
				if(deceleration)
					acceleration_value -= deceleration
				else
					acceleration_value = first_max_value
			acceleration_value = clamp(acceleration_value,0,100) //Hard cap of 100

	if(move_delay <= 0)
		is_moving = FALSE

	//Handle acceleration and deceleration
	if(!move_dir) //Not actually wanting to move.
		if(deceleration) //Remove acceleration as we are not moving.
			acceleration_value = max(acceleration_value - deceleration*adjust_delay,0)
		else
			acceleration_value = 0 //Instantly stopped
	else
		final_move_dir = sanitize_direction(final_move_dir)

	if(acceleration_value)
		acceleration_value = FLOOR(acceleration_value,0.01)

	if(adjust_delay)
		move_delay = move_delay - adjust_delay

	return is_moving

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

	post_move(old_loc)

	return TRUE

/atom/movable/proc/get_max_acceleration_value()
	return 100

/atom/movable/proc/post_move(var/atom/old_loc)

	if(grabbing_hand)
		grabbing_hand.check_grab()

	var/light_source/L
	var/thing
	for(thing in light_sources)
		L = thing
		L.source_atom.update_light()

	if(isturf(src.loc))
		for(var/k in light_sprite_sources)
			var/obj/light_sprite/LS = k
			LS.force_move(src.loc)

	HOOK_CALL("post_move")
	return TRUE

/atom/movable/Bump(atom/Obstacle)

	if(ismovable(Obstacle) && src.loc != Obstacle)
		var/atom/movable/M = Obstacle
		if(!M.anchored && (!grabbing_hand || Obstacle != grabbing_hand.owner) && M.can_be_bumped)
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

	//Try: Exit the old turf.
	if(src.density && OldLoc && !OldLoc.Exit(src,NewLoc))
		return FALSE

	//Try: Enter the new turf.
	if(src.density && !NewLoc.Enter(src,OldLoc) && !src.Bump(NewLoc))
		return FALSE

	//Try: Cross the Contents
	if(src.density)
		for(var/k in NewLoc.contents)
			CHECK_TICK(100,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(M.density && !M.Cross(src,OldLoc) && !src.Bump(M))
				return FALSE

	//Try: Uncross the Contents
	if(src.density && OldLoc)
		for(var/k in OldLoc.contents)
			CHECK_TICK(100,FPS_SERVER)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(M.density && !M.Uncross(src,NewLoc))
				return FALSE

	//Do: Enter the turf.
	if(src.density) NewLoc.Entered(src,OldLoc)

	//Do: Exit the turf.
	if(src.density) OldLoc.Exited(src,NewLoc)

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

	if(!OldLoc || OldLoc == loc)
		loc = NewLoc

	post_move(OldLoc)

	if((collision_flags & FLAG_COLLISION_WALKING) && isturf(loc))
		var/turf/T = loc
		if(T.friction < 1)
			var/calculated_speed = SECONDS_TO_DECISECONDS(glide_size/TILE_SIZE)
			var/calculated_direction = get_dir(OldLoc,loc)
			start_momentum(calculated_speed,calculated_direction)

	return TRUE

/atom/movable/proc/on_fall(var/turf/old_turf)
	return TRUE

/atom/movable/proc/start_momentum(var/desired_momentum_speed=0,var/desired_momentum_dir=0x0)

	if(!desired_momentum_speed || !desired_momentum_dir)
		return FALSE

	if(momentum_dir && momentum_dir != desired_momentum_dir)
		var/total_speed = desired_momentum_speed + momentum_speed
		var/altered_momentum_dir = dir2angle(momentum_dir) * (momentum_speed/total_speed)
		var/altered_desired_momentum_dir = dir2angle(desired_momentum_dir) * (desired_momentum_speed/total_speed)
		momentum_dir = angle2dir(altered_momentum_dir + altered_desired_momentum_dir)
	else
		momentum_dir = desired_momentum_dir

	momentum_speed = max(momentum_speed,desired_momentum_speed)

	if(!CALLBACK_EXISTS("momentum_\ref[src]"))
		process_momentum(TRUE)

	return TRUE

/atom/movable/proc/process_momentum(var/no_move=FALSE)

	if(momentum_speed <= 0 || !momentum_dir)
		return FALSE

	if(!isturf(loc))
		momentum_speed = 0
		momentum_dir = 0x0
		return FALSE

	var/turf/T = get_turf(src)
	momentum_speed -= CEILING(T.friction*momentum_speed,0.1)
	if(move_dir)
		start_momentum(momentum_speed*T.friction,move_dir)

	if(momentum_speed <= 0 || !momentum_dir)
		momentum_dir = 0x0
		return FALSE

	var/desired_delay = CEILING(10/momentum_speed,1)
	move_delay = max(move_delay,DECISECONDS_TO_TICKS(desired_delay))
	glide_size = move_delay ? CEILING(step_size/move_delay,0.01) : 1
	var/turf/desired_turf = get_step(src,momentum_dir)
	CALLBACK("momentum_\ref[src]",desired_delay,src,.proc/process_momentum)
	if(!no_move && desired_turf)
		Move(desired_turf)

	return TRUE
