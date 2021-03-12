/proc/burger_star(var/atom/movable/mover,var/turf/destination,var/ignore_destructables=FALSE,var/debug=FALSE)

	set background = TRUE

	if(debug) log_debug("Running burger_star([mover],[destination],[ignore_destructables],[debug])")

	if(!destination || !mover || mover.z != destination.z)
		return null

	var/start_time = world.time

	var/turf/starting_turf = get_turf(mover)

	if(destination == starting_turf)
		return null

	var/distance = get_dist(mover,destination) + VIEW_RANGE
	var/center_x = (mover.x + destination.x)/2
	var/center_y = (mover.y + destination.y)/2
	center_x = round(center_x)
	center_y = round(center_y)

	var/list/turf/block_turfs = block(
		locate( //Bottom left
			clamp(center_x - distance,0,WORLD_SIZE),
			clamp(center_y - distance,0,WORLD_SIZE),
			mover.z
		),
		locate( //Top right
			clamp(center_x + distance,0,WORLD_SIZE),
			clamp(center_y + distance,0,WORLD_SIZE),
			destination.z
		)
	)

	var/list/master_list = list() //For this thread. Assoc list (T = BSD)

	if(!length(block_turfs))
		if(debug) log_debug("No block turfs found!")
		return null

	//Step 1: Go through the block turfs and give them a BSD datum if you can move through them.
	for(var/k in block_turfs)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		var/area/A = T.loc
		if(T != destination && T != starting_turf)
			if(!T.Enter(node_checker))
				if(debug) T.color = COLOR_RED
				continue
			var/occupied = FALSE
			for(var/m in T.contents)
				var/atom/movable/M = m
				var/can_destroy = ignore_destructables && M.health && (A.flags_area & (FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION))
				if(M.density && !M.allow_path && !can_destroy)
					occupied = TRUE
					continue
			if(occupied)
				if(debug) T.color = COLOR_RED_DARK
				continue
		if(debug) T.color = COLOR_YELLOW
		var/burger_star_data/BSD = new
		BSD.starting_turf = starting_turf
		BSD.ending_turf = destination
		BSD.master_list = master_list
		BSD.parent_turf = T
		BSD.connected_turfs = list()
		BSD.intercardinal_turfs = list()
		master_list[T] = BSD

	//Step 2: Setup connections.
	for(var/k in master_list)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		var/burger_star_data/BSD = master_list[k]
		if(!BSD) //Could've been deleted.
			continue
		for(var/j in DIRECTIONS_CARDINAL)
			CHECK_TICK(50,FPS_SERVER)
			var/turf/T2 = get_step(T,j)
			if(!master_list[T2])
				continue
			BSD.connected_turfs[T2] = j
		for(var/j in DIRECTIONS_INTERCARDINAL)
			CHECK_TICK(50,FPS_SERVER)
			var/turf/T2 = get_step(T,j)
			if(!master_list[T2])
				continue
			BSD.intercardinal_turfs[T2] = j

	//Step 3: Validate connections.
	for(var/k in master_list)
		CHECK_TICK(50,FPS_SERVER)
		var/burger_star_data/BSD = master_list[k]
		if(!BSD) //Could've been deleted.
			continue
		if(!BSD.check_valid())
			BSD.set_invalid(debug)
			continue

	if(!length(master_list))
		if(debug) log_debug("No master turfs found!")
		return null

	if(debug)
		for(var/k in master_list)
			var/turf/T = k
			T.color = COLOR_BLUE

	var/turf/last_junction
	var/turf/current_turf = starting_turf
	var/list/current_path = list()
	var/list/current_sub_path = list(current_turf)
	var/list/turf_blacklist = list(current_turf = TRUE)

	var/attempts_left = 300

	while(TRUE)
		sleep(4)
		CHECK_TICK(50,FPS_SERVER)
		if(debug) current_turf.color = "#FFFFFF"
		attempts_left--
		if(attempts_left <= 0)
			if(debug) log_debug("Failed to find a path, ran out of attempts.")
			return null
		if(current_turf == destination)
			//current_path += current_sub_path
			break //WEW!
		turf_blacklist[current_turf] = TRUE
		var/burger_star_data/BSD = master_list[current_turf]
		if(!BSD)
			log_error("Error! Tried getting BSD data of [current_turf ? current_turf.get_debug_name() : "NULL"], but it didn't exist!")
			return null
		var/list/possible_turfs = BSD.connected_turfs.Copy()
		for(var/k in possible_turfs)
			var/turf/T = k
			if(turf_blacklist[T])
				possible_turfs -= T
				continue
		if(!length(possible_turfs))
			if(!last_junction)
				return null
			current_turf = last_junction
			if(debug)
				for(var/k in current_sub_path)
					var/turf/T = k
					T.color = "#FF00DC"
			current_sub_path.Cut()
			continue
		if(length(possible_turfs) >= 2)
			if(last_junction)
				current_path += current_sub_path
			last_junction = current_turf
			if(debug) last_junction.color = "#B200FF"
		var/turf/best_turf
		for(var/k in possible_turfs)
			var/turf/T = k
			if(!best_turf)
				best_turf = T
				break
			if(get_dist(best_turf,destination) < get_dist(T,destination))
				best_turf = T
		current_turf = best_turf
		current_sub_path += current_turf
		current_sub_path.Cut()

	if(debug)
		for(var/k in current_path)
			var/turf/T = k
			T.color = COLOR_GREEN
		log_debug("Pathfinding took [world.time - start_time] deciseconds and [300 - attempts_left] steps.")

	return current_path

/burger_star_data/
	var/turf/starting_turf
	var/turf/ending_turf
	var/turf/list/master_list
	var/turf/parent_turf
	var/list/connected_turfs
	var/list/intercardinal_turfs

/burger_star_data/Destroy()
	starting_turf = null
	master_list = null
	parent_turf = null
	connected_turfs.Cut()
	intercardinal_turfs.Cut()
	. = ..()

/burger_star_data/proc/check_valid()

	//Don't check if it's the destination or starting point.
	if(parent_turf == starting_turf || parent_turf == ending_turf)
		return TRUE

	//Dead-end checking.
	if(length(connected_turfs) < 2)
		return FALSE

	//Corner checking.
	if(length(intercardinal_turfs))
		var/direction_to_turf = list()
		for(var/k in connected_turfs)
			direction_to_turf["[connected_turfs[k]]"] = k
		for(var/k in intercardinal_turfs)
			var/direction = intercardinal_turfs[k]
			var/valid_count = 0
			for(var/j in DIRECTIONS_CARDINAL)
				var/j_inverse = turn(j,180)
				if((direction & j) && direction_to_turf["[j]"] && !direction_to_turf["[j_inverse]"])
					valid_count++
					if(valid_count >= 2)
						return FALSE

	return TRUE


/burger_star_data/proc/set_invalid(var/debug=FALSE)

	set background = TRUE

	master_list -= parent_turf

	for(var/k in connected_turfs)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		if(!master_list[T]) //Already processed.
			connected_turfs -= k
			continue
		var/burger_star_data/BSD = master_list[k]
		BSD.connected_turfs -= parent_turf
		if(!BSD.check_valid())
			BSD.set_invalid(debug)

	for(var/k in intercardinal_turfs)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		if(!master_list[T]) //Already processed.
			intercardinal_turfs -= k
			continue
		var/burger_star_data/BSD = master_list[k]
		BSD.intercardinal_turfs -= parent_turf
		if(!BSD.check_valid())
			BSD.set_invalid(debug)

	if(debug) parent_turf.color = COLOR_ORANGE

	qdel(src)

	return TRUE



