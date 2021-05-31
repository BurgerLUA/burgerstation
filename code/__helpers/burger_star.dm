//Dogshit pathfinding here.
//I don't like deleting code that took a while to make
//It's bad though. Really bad. ~BurgerBB

/proc/burger_star(var/atom/movable/mover,var/turf/destination,var/ignore_destructables=FALSE,var/list/stop_at_obstacles,var/debug=FALSE)

	set background = 1

	if(debug) log_debug("Running burger_star([mover],[destination],[ignore_destructables],[debug])")

	if(!destination || !mover || mover.z != destination.z)
		return null

	var/start_time = world.time

	var/turf/starting_turf = get_turf(mover)

	if(destination == starting_turf)
		return null

	var/distance = get_dist(mover,destination)
	if(distance >= 64)
		return null

	distance += VIEW_RANGE

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

	var/list/special_turfs = list()
	var/list/bsd_to_validate = list()

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
				CHECK_TICK(50,FPS_SERVER)
				var/atom/movable/M = m
				if(!special_turfs[T] && stop_at_obstacles)
					for(var/j in stop_at_obstacles)
						CHECK_TICK(50,FPS_SERVER)
						if(istype(M,j))
							special_turfs[T] = TRUE
							break
				if(M.density && M.anchored && !M.allow_path && (M.collision_flags & mover.collision_flags) && !(ignore_destructables && M.health && !(A.flags_area & (FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION))))
					occupied = TRUE
					break
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
		bsd_to_validate += BSD


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
	var/validation_counts = 0
	while(length(bsd_to_validate) > 0)
		CHECK_TICK(50,FPS_SERVER)
		validation_counts += 1
		if(debug && !(validation_counts % 100))
			log_debug("Validation counts exceeding [validation_counts]...")
		var/burger_star_data/BSD = bsd_to_validate[1]
		if(BSD && !BSD.qdeleting && !BSD.check_valid())
			if(debug) BSD.parent_turf.color = COLOR_ORANGE
			BSD.set_invalid(bsd_to_validate)
		bsd_to_validate -= BSD

	if(debug) log_debug("Checked the validity of [validation_counts] BSDs.")

	if(!length(master_list))
		if(debug) log_debug("No master turfs found!")
		return null

	if(debug)
		for(var/k in master_list)
			CHECK_TICK(50,FPS_SERVER)
			var/turf/T = k
			T.color = COLOR_BLUE

	var/turf/current_turf = starting_turf
	var/turf/junctions = list(current_turf)
	var/turf/junction_paths = list()
	junction_paths[current_turf] = list()
	var/turf/revert_blacklist = list()

	var/list/turf_blacklist = list(current_turf = TRUE)

	var/attempts_left = 300

	//Step 4: Path to it!
	while(TRUE)
		if(debug) sleep(3)
		CHECK_TICK(50,FPS_SERVER)
		if(debug) current_turf.color = "#FFFFFF"
		attempts_left--
		if(attempts_left <= 0)
			if(debug) log_debug("Failed to find a path, ran out of attempts.")
			return null
		if(current_turf == destination || special_turfs[current_turf])
			break //We're on the right path!
		turf_blacklist[current_turf] = TRUE
		var/burger_star_data/BSD = master_list[current_turf]
		if(!BSD)
			log_error("Error! Tried getting BSD data of [current_turf ? current_turf.get_debug_name() : "NULL"], but it didn't exist!")
			return null
		var/list/possible_turfs = BSD.connected_turfs.Copy()
		for(var/k in possible_turfs)
			CHECK_TICK(50,FPS_SERVER)
			var/turf/T = k
			if(turf_blacklist[T])
				possible_turfs -= T
				continue
		if(!length(possible_turfs)) //We've reached a dead end or a redundancy.
			if(!length(junctions)) //Yeah we've really hit a dead end.
				if(debug) log_debug("Total dead end detected...")
				return null
			var/path_num = length(junctions)
			var/turf/last_junction
			while(path_num > 0)
				CHECK_TICK(50,FPS_SERVER)
				last_junction = junctions[path_num]
				junction_paths[last_junction].Cut() //Reset
				var/burger_star_data/BSD2 = master_list[last_junction]
				if(revert_blacklist[last_junction] < length(BSD2.connected_turfs))
					break //We can go back.
				path_num--	//Can't go back!
			current_turf = last_junction
			if(!revert_blacklist[last_junction])
				revert_blacklist[last_junction] = 1
			else
				revert_blacklist[last_junction] += 1
			if(debug) log_debug("Resetting to previous junction [current_turf.get_debug_name()].")
			continue
		if(length(possible_turfs) >= 2) //We've hit a junction.
			junctions += current_turf
			junction_paths[current_turf] = list()
			if(debug)
				log_debug("Adding junction .[current_turf.get_debug_name()].")
				current_turf.color = "#B200FF"
		var/turf/best_turf
		for(var/k in possible_turfs)
			CHECK_TICK(50,FPS_SERVER)
			var/turf/T = k
			if(!best_turf)
				best_turf = T
				continue
			if(get_dist(best_turf,destination) > get_dist(T,destination))
				best_turf = T
		current_turf = best_turf
		junction_paths[junctions[length(junctions)]] += current_turf

	var/list/current_path = list()

	for(var/k in junctions)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		var/list/junction_list = junction_paths[T]
		current_path += junction_list

	if(debug)
		for(var/k in current_path)
			CHECK_TICK(50,FPS_SERVER)
			var/turf/T = k
			T.color = COLOR_GREEN
		log_debug("Pathfinding took [world.time - start_time] deciseconds and [300 - attempts_left] steps.")

	for(var/k in master_list)
		CHECK_TICK(50,FPS_SERVER)
		var/burger_star_data/BSD = master_list[k]
		qdel(BSD)

	master_list.Cut()

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
			CHECK_TICK(50,FPS_SERVER)
			direction_to_turf["[connected_turfs[k]]"] = k
		for(var/k in intercardinal_turfs)
			CHECK_TICK(50,FPS_SERVER)
			var/direction = intercardinal_turfs[k]
			var/valid_count = 0
			for(var/j in DIRECTIONS_CARDINAL)
				CHECK_TICK(50,FPS_SERVER)
				var/j_inverse = turn(j,180)
				if((direction & j) && direction_to_turf["[j]"] && !direction_to_turf["[j_inverse]"])
					valid_count++
					if(valid_count >= 2)
						return FALSE

	return TRUE


/burger_star_data/proc/set_invalid(var/list/bsd_to_validate)

	master_list -= parent_turf

	for(var/k in connected_turfs)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		if(!master_list[T]) //Already processed.
			connected_turfs -= T
			continue
		var/burger_star_data/BSD = master_list[T]
		BSD.connected_turfs -= parent_turf
		bsd_to_validate |= BSD

	for(var/k in intercardinal_turfs)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		if(!master_list[T]) //Already processed.
			intercardinal_turfs -= T
			continue
		var/burger_star_data/BSD = master_list[T]
		BSD.intercardinal_turfs -= parent_turf
		bsd_to_validate |= BSD

	qdel(src)

	return TRUE



