/proc/reverse_direction(var/dir)
	return turn(dir, 180)

proc/direction_to_pixel_offset(var/dir)
	var/offset_x = (dir & EAST ? 1 : 0) - (dir & WEST ? 1 : 0)
	var/offset_y = (dir & NORTH ? 1 : 0) - (dir & SOUTH ? 1 : 0)
	return list(offset_x,offset_y)

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