/atom/proc/set_dir(var/desired_direction)
	dir = desired_direction

/atom/proc/face_atom(var/atom/A)
	if(!A || !x || !y || !A.x || !A.y) return
	var/dx = A.x - x
	var/dy = A.y - y

	var/direction
	if (loc == A.loc)
		direction = A.dir
	else if (!dx && !dy)
		return
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

	if(direction != dir)
		set_dir(direction)