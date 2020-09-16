/proc/split_direction(var/input=0x0)
	. = list()
	for(var/dir in DIRECTIONS_CARDINAL)
		if(input & dir)
			. += dir
	return .