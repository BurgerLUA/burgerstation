/atom/movable/
	var/tmp/move_dir = 0
	var/tmp/move_delay = 0
	var/movement_delay = 4
	var/anchored = FALSE

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE | KEEP_TOGETHER

	animate_movement = FALSE

	var/ghost = FALSE

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/update_glide()
	glide_size = round(step_size / max(get_movement_delay(),TICK_LAG) * TICK_LAG)

/atom/movable/proc/handle_movement(var/adjust_delay = FALSE)

	if(move_dir && move_delay <= 0)
		update_glide()
		var/final_movement_delay = round(get_movement_delay())
		do_move(get_step(src,move_dir),final_movement_delay)
		move_delay = max(final_movement_delay,move_delay + final_movement_delay)
		return TRUE
	else
		if(adjust_delay)
			move_delay = move_delay - TICK_LAG
		return FALSE

/atom/movable/proc/can_move(var/turf/new_loc,var/movement_override = 0)

	if(loc == new_loc) //Don't bother moving.
		return FALSE

	if(!new_loc)
		return FALSE

	/*
	if(!can_attack())
		return FALSE
	*/

	/*
	if(attack_last + (ATTACK_ANIMATION_LENGTH * 1.5) + 1 >= world.time)
		return FALSE
	*/

	var/move_direction = loc.get_relative_dir(new_loc)

	if(ghost)
		return TRUE

	if(loc)
		var/atom/A = loc.can_not_leave(src,move_direction) //Is there an object preventing us from leaving?
		if(A && !A.do_bump(src,move_direction,movement_override))
			return FALSE

	if(new_loc)
		var/atom/A = new_loc.can_not_enter(src,move_direction) //Is there an object prevent us from entering?
		if(A && !A.do_bump(src,move_direction,movement_override))
			return FALSE

	return TRUE

/atom/movable/proc/do_move(var/new_loc,var/movement_override = 0)
	if(!can_move(new_loc,movement_override))
		src.face_atom(new_loc)
		return FALSE
	do_step(new_loc, movement_override)
	return TRUE

/atom/movable/proc/force_move(var/atom/new_loc, var/trigger_enter = TRUE, var/trigger_exit = TRUE)

	var/atom/old_loc = null

	if(loc)
		if(loc == new_loc)
			return old_loc
		old_loc = loc
		if(trigger_exit)
			old_loc.on_exit(src)

	if(new_loc)
		src.loc = new_loc
		if(trigger_enter)
			new_loc.on_enter(src)

	for(var/datum/light_source/L in src.light_sources) // Cycle through the light sources on this atom and tell them to update.
		L.source_atom.update_light()

	return old_loc

/atom/movable/proc/do_step(var/atom/new_loc, var/movement_override = 0)
	var/turf/old_loc = loc
	do_movement_effects(old_loc,new_loc,movement_override)
	return force_move(new_loc)

/atom/movable/proc/do_movement_effects(var/atom/old_loc, var/atom/new_loc, var/movement_override = 0)

	var/pixel_x_offset = -(new_loc.x - old_loc.x)*step_size
	var/pixel_y_offset = -(new_loc.y - old_loc.y)*step_size

	var/real_movement_delay = movement_override ? movement_override : get_movement_delay()
	var/movement_dir = old_loc.get_relative_dir(new_loc)

	animate(src, pixel_x = src.pixel_x + pixel_x_offset, pixel_y = src.pixel_y + pixel_y_offset, time = 1, flags = ANIMATION_LINEAR_TRANSFORM)
	animate(src, pixel_x = src.pixel_x - pixel_x_offset, pixel_y = src.pixel_y - pixel_y_offset, time = real_movement_delay, flags = ANIMATION_LINEAR_TRANSFORM, dir = movement_dir)

	return TRUE

/atom/movable/can_attack(var/atom/victim,var/params)
	/*
	if(move_delay >= get_movement_delay()*0.5)
		return FALSE
	*/

	return ..()