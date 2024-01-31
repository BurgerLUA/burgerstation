/atom/movable/proc/get_movement_delay(var/include_stance=TRUE)
	return movement_delay


/*
/atom/movable/proc/can_enter_turf(var/turf/T,var/loc_overide = src.loc)

	if(!T.has_dense_atom)
		return TRUE

	if(!T.Enter(src,loc_overide))
		return FALSE

	for(var/k in T.contents)
		var/atom/movable/M = k
		if(M.density && !M.Cross(src,loc_overide))
			return FALSE

	return TRUE
*/



/atom/movable/proc/handle_movement(var/adjust_delay = 1) //Measured in ticks

	if(anchored || CALLBACK_EXISTS("momentum_\ref[src]"))
		is_moving = FALSE
		return FALSE

	var/final_move_dir = move_dir

	if(!move_dir && use_momentum && move_dir_last && acceleration_value > 0)
		final_move_dir = move_dir_last

	if(final_move_dir && next_move <= 0 && is_valid_dir(final_move_dir))

		var/final_movement_delay = get_movement_delay()
		var/intercardinal = is_intercardinal_dir(final_move_dir)

		if(intercardinal)
			final_movement_delay *= SQRT2

		if(src.loc && (collision_flags & FLAG_COLLISION_WALKING) && is_simulated(src.loc))
			var/turf/simulated/T = loc
			final_movement_delay *= T.move_delay_modifier

		var/final_movement_delay_before_accel = final_movement_delay
		if(acceleration_mod > 0)
			var/accel_decimal = 1 - clamp(acceleration_value/100,0,1)
			final_movement_delay *= 1 + (accel_decimal*acceleration_mod)

		var/desired_next_move = CEILING(final_movement_delay, adjust_delay)
		if(desired_next_move > 0)
			glide_size = step_size/desired_next_move

		if(glide_size < FPS_CLIENT/FPS_SERVER)
			glide_size = FPS_CLIENT/FPS_SERVER
		else
			desired_next_move = step_size/glide_size //We do this so that glide movement doesn't look weird.

		next_move = max(desired_next_move,next_move)

		//Handling intercardinal collisions.
		if(intercardinal)
			var/first_move_dir_to_use = src.first_move_dir ? src.first_move_dir : get_true_4dir(final_move_dir)
			var/second_move_dir_to_use = final_move_dir & ~first_move_dir_to_use
			var/turf/first_step = get_step(src,first_move_dir_to_use)
			var/turf/second_step = get_step(src,second_move_dir_to_use)

			if(second_step) //Safety.
				var/second_from_loc = !second_step.density || second_step.Enter(src,first_step)
				if(second_from_loc)
					if(second_step.has_dense_atom)
						for(var/k in second_step.contents)
							var/atom/movable/M = k
							if(M.density && !M.Cross(src,first_step))
								second_step = null
								break
				else
					second_step = null
			if(!second_step)
				final_move_dir &= ~second_move_dir_to_use

			if(second_step && first_step) //Safety.
				var/first_from_loc = !first_step.density || first_step.Enter(src,src.loc)
				if(first_from_loc)
					if(first_step.has_dense_atom)
						for(var/k in first_step.contents)
							var/atom/movable/M = k
							if(M.density && !M.Cross(src,src.loc))
								first_step = null
								break
				else
					first_step = null
			if(!first_step)
				final_move_dir &= ~first_move_dir_to_use

		//Storing previous move dir and handling inability to move.
		var/similiar_move_dir = FALSE
		var/turf/step = final_move_dir ? get_step(src,final_move_dir) : null
		if(step && Move(step,final_move_dir))
			if(move_dir_last & final_move_dir)
				similiar_move_dir = TRUE
			move_dir_last = final_move_dir
			is_moving = TRUE
		else //Blocked by a wall or something.
			move_dir_last = 0x0
			next_move = max(next_move,DECISECONDS_TO_TICKS(1))
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

	if(next_move <= 0)
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
		next_move = max(0,next_move - adjust_delay)

	return is_moving

/atom/movable/proc/force_move(var/atom/new_loc)

	var/atom/old_loc = loc

	var/turf/old_loc_as_turf = is_turf(old_loc) ? old_loc : null
	var/turf/new_loc_as_turf = is_turf(new_loc) ? new_loc : null

	if(old_loc)
		old_loc.Exited(src, new_loc)
		if(old_loc && src.density && (!old_loc_as_turf || old_loc_as_turf.has_dense_atom))
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
		if(new_loc && src.density && (!new_loc_as_turf || new_loc_as_turf.has_dense_atom))
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

	for(var/k in light_sprite_sources)
		var/obj/light_sprite/LS = k
		LS.force_move(src.loc)

	if(enable_chunk_handling && SSchunk.initialized && src.finalized)

		var/chunk/old_chunk = is_turf(old_loc) ? CHUNK(old_loc) : null
		var/chunk/new_chunk = is_turf(loc) ? CHUNK(loc) : null
		if(old_chunk != new_chunk)
			src.on_chunk_cross(old_chunk,new_chunk)

	HOOK_CALL("post_move")
	return TRUE

/atom/movable/proc/on_chunk_cross(var/chunk/old_chunk,var/chunk/new_chunk)

	if(enable_chunk_clean)
		if(new_chunk) new_chunk.cleanables += src
		if(old_chunk) old_chunk.cleanables -= src

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

	if(!NewLoc)
		CRASH("Tried moving [src.get_debug_name()] into nullspace via Move(). Use force_move() instead.")
		return FALSE

	var/turf/old_loc_as_turf = is_turf(OldLoc) ? OldLoc : null
	var/turf/new_loc_as_turf = is_turf(NewLoc) ? NewLoc : null

	if(change_dir_on_move && Dir)
		set_dir(Dir)

	if(src.density)
		//Try: Exit the old loc.
		if(OldLoc && !OldLoc.Exit(src,NewLoc))
			return FALSE

		//Try: Enter the new loc.
		if(!NewLoc.Enter(src,OldLoc) && !src.Bump(NewLoc))
			return FALSE

		//Try: Uncross the Contents
		if(OldLoc && (!old_loc_as_turf || old_loc_as_turf.has_dense_atom))
			for(var/k in OldLoc.contents)
				CHECK_TICK(100,FPS_SERVER)
				var/atom/movable/M = k
				if(M == src)
					continue
				if(M.density && !M.Uncross(src,NewLoc))
					return FALSE

		//Try: Cross the Contents
		if((!new_loc_as_turf || new_loc_as_turf.has_dense_atom))
			for(var/k in NewLoc.contents)
				CHECK_TICK(100,FPS_SERVER)
				var/atom/movable/M = k
				if(M == src)
					continue
				if(M.density && !M.Cross(src,OldLoc) && !src.Bump(M))
					return FALSE

	if(!OldLoc || OldLoc == loc) //Special code here. the OldLoc check is for if any of the above procs moved the atom while it was being called.
		loc = NewLoc

	if(src.density)

		//No going back. We're moving.

		//Do: Exit the turf.
		OldLoc.Exited(src,NewLoc)

		//Do: Enter the turf.
		NewLoc.Entered(src,OldLoc)

		//Do: Uncrossed the contents
		if(OldLoc && (!old_loc_as_turf || old_loc_as_turf.has_dense_atom))
			for(var/k in OldLoc.contents)
				CHECK_TICK(100,FPS_SERVER)
				var/atom/movable/M = k
				if(M == src)
					continue
				if(!M.density)
					continue
				M.Uncrossed(src,NewLoc)

		//Do: Crossed the contents
		if(!new_loc_as_turf || new_loc_as_turf.has_dense_atom)
			for(var/k in NewLoc.contents)
				CHECK_TICK(100,FPS_SERVER)
				var/atom/movable/M = k
				if(M == src)
					continue
				if(!M.density)
					continue
				M.Crossed(src,OldLoc)
	else
		//Do: Exit the turf.
		if(OldLoc) OldLoc.Exited(src,NewLoc) //Can be null.

		//Do: Enter the turf.
		NewLoc.Entered(src,OldLoc)

	post_move(OldLoc)

	return TRUE

/atom/movable/proc/on_fall(var/turf/old_turf)
	return TRUE

/*
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

	if(!src.z)
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
	next_move = max(next_move,DECISECONDS_TO_TICKS(desired_delay))
	glide_size = next_move ? CEILING(step_size/next_move,0.01) : 1
	var/turf/desired_turf = get_step(src,momentum_dir)
	CALLBACK("momentum_\ref[src]",desired_delay,src,src::process_momentum())
	if(!no_move && desired_turf)
		Move(desired_turf)

	return TRUE
*/
