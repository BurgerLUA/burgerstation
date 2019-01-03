/atom/movable/
	var/tmp/move_dir = 0
	var/tmp/move_delay = 0
	var/movement_delay = 4

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE

	animate_movement = FALSE

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/update_glide()
	glide_size = round(step_size / max(get_movement_delay(),TICK_LAG) * TICK_LAG)

/atom/movable/proc/handle_movement(var/adjust_delay = FALSE)
	if(move_dir && move_delay <= 0)
		update_glide()
		do_move(get_step(src,move_dir))
		var/final_movement_delay = get_movement_delay()
		move_delay = max(final_movement_delay,move_delay + final_movement_delay)
		return TRUE
	else
		if(adjust_delay)
			move_delay = move_delay - TICK_LAG
		return FALSE

/atom/movable/proc/can_move(var/turf/new_loc)
	if(!new_loc)
		return FALSE

	if(!can_attack())
		return FALSE

	if(attack_last + (ATTACK_ANIMATION_LENGTH * 1.5) + 1 >= world.time)
		return FALSE

	var/move_direction = loc.get_relative_dir(new_loc)

	if(loc)
		var/atom/A = loc.can_not_leave(src,move_direction) //Is there an object preventing us from leaving?
		if(A && !A.do_bump(src,move_direction))
			return FALSE

	if(new_loc)
		var/atom/A = new_loc.can_not_enter(src,move_direction) //Is there an object prevent us from entering?
		if(A && !A.do_bump(src,move_direction))
			return FALSE

	return TRUE

/atom/movable/proc/do_move(var/turf/new_loc)
	if(!can_move(new_loc))
		src.face_atom(new_loc)
		return FALSE
	do_step(new_loc)
	return TRUE

/atom/movable/proc/do_step(var/turf/new_loc)
	var/turf/old_loc = loc
	old_loc.on_exit(src)
	do_movement_effects(old_loc,new_loc)
	loc = new_loc
	x = new_loc.x
	y = new_loc.y
	z = new_loc.z
	new_loc.on_enter(src)
	//action_last = world.time
	return FALSE

/atom/movable/proc/do_movement_effects(var/turf/old_loc,var/turf/new_loc)
	return TRUE

/atom/movable/can_attack(var/atom/victim,var/params)

	if(move_delay >= get_movement_delay()*0.5)
		return FALSE

	return ..()