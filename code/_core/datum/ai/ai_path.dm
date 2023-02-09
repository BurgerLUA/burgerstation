/ai/proc/set_path_fallback(var/turf/destination)

	if(master_ai)
		return FALSE

	if(!destination)
		CRASH("Invalid destination provided!")

	var/turf/T = get_turf(owner)
	if(get_dist(T,destination) >= VIEW_RANGE)
		return set_path_astar(destination)

	var/obj/marker/map_node/N_start = find_closest_node(owner)
	if(!N_start)
		if(debug) log_debug("[src.get_debug_name()] tried node pathing, but couldn't find a valid start node.")
		return set_path_astar(destination)

	var/obj/marker/map_node/N_end = find_closest_node(destination)
	if(!N_end)
		if(debug) log_debug("[src.get_debug_name()] tried node pathing, but couldn't find a valid end node.")
		return set_path_astar(destination)

	if(length(node_path_current) && N_start && N_end && N_start == node_path_current[1] && N_end == node_path_current[length(node_path_current)])
		if(debug) log_debug("[src.get_debug_name()] tried node pathing, but the path was the same as last path!")
		if(set_path_astar(destination))
			return TRUE

	var/list/obj/marker/map_node/found_path = AStar_Circle_node(N_start,N_end)
	if(!found_path)
		if(debug) log_debug("[src.get_debug_name()] tried astar pathing, but couldn't find a valid node path.")
		return set_path_astar(destination)

	return set_path_node(found_path)

/ai/proc/set_path_node(var/list/obj/marker/map_node/desired_path)

	if(!desired_path || !length(desired_path))
		node_path_current = null
		node_path_start_turf = null
		node_path_end_turf = null
		node_path_current_step = null
		frustration_node_path = 0
		return TRUE

	if(master_ai)
		return FALSE

	set_active(TRUE)

	node_path_current_step = 1
	node_path_current = desired_path
	frustration_node_path = 0
	frustration_move = 0
	owner.move_dir = 0x0
	node_path_start_turf = get_turf(owner)

	var/obj/marker/map_node/last_node = node_path_current[length(node_path_current)]
	node_path_end_turf = locate(last_node.x,last_node.y,last_node.z)

	if(check_for_obstructions) check_node_path_obstructions()

	if(debug)
		for(var/k in desired_path)
			var/obj/marker/map_node/MN = k
			MN.alpha = 255
			MN.invisibility = 0

	for(var/k in linked_ais)
		var/ai/A = k
		A.node_path_current_step = 1
		A.node_path_current = desired_path.Copy()
		A.frustration_node_path = 0
		A.frustration_move = 0
		A.owner.move_dir = 0x0
		A.node_path_start_turf = node_path_start_turf
		A.node_path_end_turf = node_path_end_turf

	return TRUE

/ai/proc/set_path_astar(var/turf/destination,var/min_distance=0)

	frustration_astar_path = 0
	frustration_move = 0

	if(master_ai)
		return FALSE

	set_active(TRUE)

	if(astar_path_current)
		astar_path_current.Cut()
		astar_path_current = null

	if(destination)
		var/list/returning_path = AStar_Circle(get_turf(owner),destination,owner,min_distance)
		if(returning_path)
			astar_path_current = returning_path
			set_active(TRUE)
			for(var/k in linked_ais)
				var/ai/A = k
				A.astar_path_current = returning_path.Copy()
				A.set_active(TRUE)
			return TRUE
		else
			if(debug) log_debug("[src.get_debug_name()] tried astar pathing, but couldn't find a valid astar path.")

