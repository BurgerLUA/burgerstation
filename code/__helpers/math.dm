/proc/split_direction(input=0x0)
	. = list()
	for(var/dir in DIRECTIONS_CARDINAL)
		if(input & dir)
			. += dir


/proc/nice_number(input)

	var/absolute = abs(input)

	if(absolute >= 1e12)
		return "[FLOOR(input/1e12,0.1)]t"
	else if(absolute >= 1e9)
		return "[FLOOR(input/1e9,0.1)]b"
	else if(absolute >= 1e6)
		return "[FLOOR(input/1e6,0.1)]m"
	else if(absolute >= 1e5)
		return "[FLOOR(input/1e3,0.1)]k"

	return "[input]"

/proc/rand_map(turf/T,n = 50,seed=1) //0 to 100.

	if(n <= 0)
		return FALSE
	if(n >= 100)
		return TRUE

	var/found_number = text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[T.z]]","[T.x / world.maxx]","[T.y / world.maxy]"))

	return found_number*100 <= n
