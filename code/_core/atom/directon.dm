/atom/proc/set_dir(var/desired_direction=0x0,var/force = FALSE)

	if(!desired_direction)
		return FALSE

	if(!force && dir == desired_direction)
		return FALSE

	dir = desired_direction

	return dir

/atom/proc/face_atom(var/atom/A)
	return set_dir(get_relative_dir(A))

/atom/proc/get_relative_dir(var/atom/A)
	if(!A || !x || !y || !A.x || !A.y) return
	var/dx = A.x - x
	var/dy = A.y - y

	var/direction
	if (!dx && !dy)
		return 0
	else if(abs(dx) < abs(dy))
		if(dy > 0)
			direction = NORTH
		else
			direction = SOUTH
	else
		if(dx > 0)
			direction = EAST
		else
			direction = WEST

	return direction


/atom/movable/proc/setup_dir_offsets()
	var/x_offset = 0
	var/y_offset = 0

	if(dir & NORTH)
		pixel_y -= dir_offset
		light_offset_y -= dir_offset*0.5
		y_offset++

	if(dir & SOUTH)
		pixel_y += dir_offset
		light_offset_y += dir_offset*0.5
		y_offset--

	if(dir & EAST)
		pixel_x -= dir_offset
		light_offset_x -= dir_offset*0.5
		x_offset++

	if(dir & WEST)
		pixel_x += dir_offset
		light_offset_x += dir_offset*0.5
		x_offset--

	loc = locate(x+x_offset,y+y_offset,z) //Legitimately don't know why force_move or get_step doesn't work here. Even in initialize.

	return TRUE