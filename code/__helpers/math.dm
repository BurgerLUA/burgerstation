/proc/split_direction(var/input=0x0)
	. = list()
	for(var/dir in DIRECTIONS_CARDINAL)
		if(input & dir)
			. += dir
	return .



/proc/nice_number(var/input)

	var/absolute = abs(number)

	if(absolute >= 1000000)
		return "[FLOOR(number/1000000,0.1)]m"

	else if(absolute >= 10000)
		return "[FLOOR(number/1000,0.1)]k"

	return "[number]"