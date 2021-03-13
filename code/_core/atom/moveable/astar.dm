/proc/get_astar_path(var/atom/movable/mover,var/turf/source,var/turf/destination,var/needed_distance)

	set background = 1

	if(!source || !destination)
		return null

	var/list/turf/destination_turfs = astar_get_circle(destination,needed_distance)

	for(var/k in destination_turfs)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = k
		if(mover)
			if(!T.Enter(mover))
				destination_turfs -= k
				continue
		else
			if(!T.is_safe_teleport())
				destination_turfs -= k
				continue

	if(!length(destination_turfs))
		return null

	var/list/turf/turf_path = list()
	var/path_node/current_square
	var/path_node/open_list = new
	var/path_node/closed_list = new

	var/turf/current_turf = source

	var/max_search_threshold = get_dist(source,destination) + ASTAR_MAX_SEARCHES

	var/cost_estimate = (source.get_movement_cost(mover) + destination.get_movement_cost(mover)) / 2

	var/path_node/atom_node = new(mover,source,destination)
	open_list += atom_node

	var/found_path = 0

	while((length(open_list) > 0) && !path_found)
		if(length(closed_list) > max_search_threshold)
			return null //Can't find a path.

		//Find lowest cost square.
		current_square = open_list[1]

		//Switch to closed list.
		closed_list.Insert(1,current_square)
		open_list -= current_square

		for(var/k in destination_turfs)
			var/turf/T = k
			if(current_square == destination)
				path_found = TRUE
				break

		if(path_found)
			continue

		var/is_in_closed_list = FALSE
		var/is_in_open_list = FALSE
		var/path_node/open_list_found_square

		var/list/turf/new_turfs_to_investigate = astar_path_get_adjacent_turfs(current_square.my_turf)

		for(var/k in new_turfs_to_investigate)
			var/turf/T = k
			//Check if the turf is walkable.
			if(mover)
				if(!T.Enter(mover))
					continue
			else
				if(!T.is_safe_teleport())
					continue

			is_in_closed_list = FALSE //Reset.

			for(var/k in closed_list)
				var/path_node/closed_list_square = k
				if(closed_list_square.my_turf == T)
					is_in_closed_list = TRUE
					break

			if(is_in_closed_list)
				continue

			//var/path_node/new_square = new(T,destination,mover,current_square)

			//If it isn't in the open list.

			is_in_open_list = FALSE
			open_list_found_square = null

			for(var/k in open_list)
				var/path_node/open_list_square = k
				if(open_list_square.my_turf == current_square)
					is_in_open_list = TRUE
					open_list_found_square = open_list_square
					break

			if(!is_in_open_list)
				var/new_






















/proc/get_astar_circle()

