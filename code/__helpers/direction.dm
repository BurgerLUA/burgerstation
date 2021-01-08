/proc/reverse_direction(var/dir)
	return turn(dir, 180)

proc/direction_to_pixel_offset(var/dir)
	var/offset_x = (dir & EAST ? 1 : 0) - (dir & WEST ? 1 : 0)
	var/offset_y = (dir & NORTH ? 1 : 0) - (dir & SOUTH ? 1 : 0)
	return list(offset_x,offset_y)

/proc/get_angle(var/atom/A1,var/atom/A2)
	if(!A1 || !A2)
		return 0
	return ATAN2(A2.x - A1.x,A1.y - A2.y)

/atom/proc/is_facing(var/atom/A) //Strict means 90 degree cone. Not means 180 degree cone.

	var/sight_dir = get_dir(src,A)

	if(dir == sight_dir)
		return TRUE

	if(turn(dir,45) == sight_dir)
		return TRUE

	if(turn(dir,-45) == sight_dir)
		return TRUE

	return FALSE


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

	return .