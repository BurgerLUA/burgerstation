/proc/split_direction(var/input=0x0)
	. = list()
	for(var/dir in DIRECTIONS_CARDINAL)
		if(input & dir)
			. += dir
	return .



/proc/nice_number(var/input)

	var/absolute = abs(input)

	if(absolute >= 1000000000)
		return "[FLOOR(input/1000000000,0.1)]m"

	else if(absolute >= 1000000)
		return "[FLOOR(input/1000000,0.1)]m"

	else if(absolute >= 100000)
		return "[FLOOR(input/1000,0.1)]k"

	return "[input]"