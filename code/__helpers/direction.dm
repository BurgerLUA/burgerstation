/proc/reverse_direction(var/dir)
	return turn(dir, 180)

proc/direction_to_pixel_offset(var/dir)
	var/offset_x = (dir & EAST ? 1 : 0) - (dir & WEST ? 1 : 0)
	var/offset_y = (dir & NORTH ? 1 : 0) - (dir & SOUTH ? 1 : 0)
	return list(offset_x,offset_y)

/proc/get_angle(var/atom/A1,var/atom/A2)
	if(!A1 || !A1.z || !A2 || !A2.z)
		return 0
	return MODULUS(ATAN2(A2.x - A1.x,A1.y - A2.y) + 90,360) //The 90 offset is needed.

/proc/is_behind(var/atom/A,var/atom/B) //Returns the facing direction if A is directly behind B.
	return get_true_4dir(B.dir) & get_dir_advanced(A,B)

/proc/is_facing(var/atom/A,var/atom/B) //Returns the facing direction if A is facing B.
	return get_true_4dir(A.dir) & get_dir_advanced(A,B)

/proc/get_directional_offsets(var/atom/A,var/atom/B)
	var/angle = get_angle(A,B)
	return list(sin(angle),cos(angle))

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

	switch(dir)
		if(SOUTHWEST)
			dir = previous_dir & SOUTH ? SOUTH : WEST
		if(SOUTHEAST)
			dir = previous_dir & SOUTH ? SOUTH : EAST
		if(NORTHWEST)
			dir = previous_dir & NORTH ? NORTH : WEST
		if(NORTHEAST)
			dir = previous_dir & NORTH ? NORTH : EAST

	return dir

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