/proc/reverse_direction(var/dir)
	return turn(dir, 180)

proc/direction_to_pixel_offset(var/dir)
	var/offset_x = (dir & EAST ? 1 : 0) - (dir & WEST ? 1 : 0)
	var/offset_y = (dir & NORTH ? 1 : 0) - (dir & SOUTH ? 1 : 0)
	return list(offset_x,offset_y)

/atom/proc/is_facing(var/atom/A) //Strict means 90 degree cone. Not means 180 degree cone.

	var/sight_dir = get_dir(src,A)

	var/list/sight_dirs = list(
		"[dir]" = TRUE,
		"[turn(dir,45)]" = TRUE,
		"[turn(dir,-45)]" = TRUE
	)

	return sight_dirs["[sight_dir]"]


proc/direction_to_text(var/dir)

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