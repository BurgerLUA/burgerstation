/atom/movable/
	var/tmp/move_dir = 0
	var/tmp/move_delay = 0
	var/movement_delay = 4

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/update_glide()
	glide_size = round(step_size / max(get_movement_delay(),TICK_LAG) * TICK_LAG)

/atom/movable/proc/handle_movement(var/adjust_delay = FALSE)
	if(move_dir && move_delay == 0)
		update_glide()
		Move(get_step(src,move_dir),move_dir)
		move_delay += get_movement_delay()
		return TRUE
	else
		if(adjust_delay)
			move_delay = max(0,move_delay - 1)
		return FALSE

/atom/movable/Move(NewLoc,Dir=0,step_x=0,step_y=0)
	if(istype(NewLoc,/turf/))
		var/turf/T = NewLoc
		if(!T.can_pass(src,Dir))
			dir = Dir
			return FALSE

	. = ..()