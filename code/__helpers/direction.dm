/proc/reverse_direction(var/dir)
	return turn(dir, 180)

proc/direction_to_pixel_offset(var/dir)
	var/offset_x = (dir & EAST ? 1 : 0) - (dir & WEST ? 1 : 0)
	var/offset_y = (dir & NORTH ? 1 : 0) - (dir & SOUTH ? 1 : 0)
	return list(offset_x,offset_y)

/proc/get_angle(var/atom/A1,var/atom/A2)
	if(!A1 || !A1.z || !A2 || !A2.z)
		return 0
	return MODULUS(ATAN2(A1.x - A2.x,A2.y - A1.y) - 90,360) //The 90 offset is needed.

/proc/is_behind(var/atom/A,var/atom/B) //Returns the facing direction if A is directly behind B.
	return A.loc != B.loc && (get_true_4dir(B.dir) & get_dir_advanced(A,B))

/proc/is_facing(var/atom/A,var/atom/B) //Returns the facing direction if A is facing B.
	return A.loc != B.loc && (get_true_4dir(A.dir) & get_dir_advanced(A,B))

/proc/is_facing_cheap(var/atom/A,var/atom/B) //Returns the facing direction if A is facing B.
	return A.loc != B.loc && (get_true_4dir(A.dir) & get_dir(A,B))

/proc/get_directional_offsets(var/atom/A,var/atom/B)
	var/x_diff = B.x - A.x
	var/y_diff = B.y - A.y
	var/maximum = max(abs(x_diff),abs(y_diff))
	if(!maximum)
		return list(0,0)
	x_diff *= 1/maximum
	y_diff *= 1/maximum
	return list(x_diff,y_diff)

proc/dir2text(var/dir)

	. = list()

	if(dir & NORTH)
		. += "north"
	if(dir & SOUTH)
		. += "south"
	if(dir &EAST)
		. += "east"
	if(dir & WEST)
		. += "west"

	return english_list(.,"none","-","-")

proc/get_true_4dir(var/dir) //Converts a possible 8 way dir into a 4 way dir.

	switch(dir)
		if(SOUTHWEST)
			dir = WEST
		if(SOUTHEAST)
			dir = EAST
		if(NORTHWEST)
			dir = WEST
		if(NORTHEAST)
			dir = EAST

	return dir

proc/get_true_4dir_advanced(var/previous_dir,var/dir) //Converts a possible 8 way dir into a 4 way dir.

	. = dir

	switch(dir)
		if(SOUTHWEST)
			. = (previous_dir & SOUTH) ? SOUTH : WEST
		if(SOUTHEAST)
			. = (previous_dir & SOUTH) ? SOUTH : EAST
		if(NORTHWEST)
			. = (previous_dir & NORTH) ? NORTH : WEST
		if(NORTHEAST)
			. = (previous_dir & NORTH) ? NORTH : EAST

	return .

/proc/get_dir_advanced(var/atom/A,var/atom/B,var/cardinal_only=FALSE)
	var/angle = get_angle(A,B)
	return cardinal_only ? angle2dir_cardinal(angle) : angle2dir(angle)

/proc/sanitize_direction(var/dir)
	. = 0x0

	var/north = dir & NORTH
	var/east = dir & EAST
	var/south = dir & SOUTH
	var/west = dir & WEST

	if(north && !south)
		. |= NORTH

	if(south && !north)
		. |= SOUTH

	if(east && !west)
		. |= EAST

	if(west && !east)
		. |= WEST

/proc/dir2letter(var/x)
	return "[x & 1 ? "n" : ""][x & 2 ? "s" : ""][x & 4 ? "e" : ""][x & 8 ? "w" : ""]"