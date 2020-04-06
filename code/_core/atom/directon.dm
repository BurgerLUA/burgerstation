/atom/proc/set_dir(var/desired_direction,var/force = FALSE)

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