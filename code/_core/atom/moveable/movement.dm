/atom/movable/
	var/tmp/move_dir = 0
	var/tmp/move_delay = 0
	var/movement_delay = 8

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE
	animate_movement = TRUE

	glide_size = 1

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/update_glide()
	glide_size = step_size / max(get_movement_delay(),10 / world.fps) * (10 / world.fps)

/atom/movable/proc/handle_movement(var/adjust_delay = FALSE)
	if(move_dir && move_delay == 0)
		update_glide()
		src << glide_size
		Move(get_step(src,move_dir),move_dir)
		move_delay += get_movement_delay()
		return TRUE
	else
		if(adjust_delay)
			move_delay = max(0,move_delay - 1)
		return FALSE