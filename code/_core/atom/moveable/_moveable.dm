atom/movable
	appearance_flags = LONG_GLIDE
	var/tmp/move_dir = 0
	var/tmp/move_delay = 0
	var/movement_delay = 8
	step_size = TILE_SIZE
	glide_size = TILE_SIZE

/atom/movable/proc/update_movement()
	glide_size = step_size / max(get_movement_delay(),1) * FPS_LAG * 0.9

/atom/movable/proc/get_movement_delay()
	return movement_delay

/atom/movable/proc/handle_movement(var/adjust_delay = FALSE)
	if(move_dir && move_delay == 0)
		update_movement()
		step(src,move_dir)
		move_delay += get_movement_delay()
		return TRUE
	else
		if(adjust_delay)
			move_delay = max(0,move_delay - 1)
		return FALSE