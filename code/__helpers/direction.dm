/proc/reverse_direction(var/dir)
	return turn(dir, 180)

proc/direction_to_pixel_offset(var/dir)
	var/offset_x = (dir & EAST ? 1 : 0) - (dir & WEST ? 1 : 0)
	var/offset_y = (dir & NORTH ? 1 : 0) - (dir & SOUTH ? 1 : 0)
	return list(offset_x,offset_y)