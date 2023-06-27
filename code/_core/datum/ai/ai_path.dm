/ai/proc/set_path_fallback(var/turf/destination,var/atom/pathing_object)

	if(master_ai)
		return FALSE

	if(!destination)
		CRASH("Invalid destination provided!")

	var/turf/T = get_turf(owner)

	if(get_dist(T,destination) <= VIEW_RANGE) //Small enough to do it.
		return set_path_astar(destination,pathing_object=pathing_object)

	var/obj/marker/map_node/N_start = find_closest_node(owner)
	if(!N_start)
		if(debug) log_debug("[src.get_debug_name()] tried node pathing, but couldn't find a valid start node.")
		return set_path_astar(destination,pathing_object=pathing_object)

	var/obj/marker/map_node/N_end = find_closest_node(destination)
	if(!N_end)
		if(debug) log_debug("[src.get_debug_name()] tried node pathing, but couldn't find a valid end node.")
		return set_path_astar(destination,pathing_object=pathing_object)

	if(length(node_path_current) && N_start && N_end && N_start == node_path_current[1] && N_end == node_path_current[length(node_path_current)])
		if(debug) log_debug("[src.get_debug_name()] tried node pathing, but the path was the same as last path!")
		if(set_path_astar(destination,pathing_object=pathing_object))
			return TRUE

	var/list/obj/marker/map_node/found_path = AStar_Circle_node(N_start,N_end)
	if(!found_path)
		if(debug) log_debug("[src.get_debug_name()] tried astar node pathing, but couldn't find a valid node path.")
		return set_path_astar(destination,pathing_object=pathing_object)

	return set_path_node(found_path,pathing_object=pathing_object)

/ai/proc/set_path_node(var/list/obj/marker/map_node/desired_path,var/atom/pathing_object)

	if(!desired_path || !length(desired_path))
		if(node_path_current)
			node_path_current = null
			node_path_start_turf = null
			node_path_end_turf = null
			node_path_current_step = null
			node_path_current_object = null
			frustration_node_path = 0
			obstacles.Cut()
		return TRUE

	if(master_ai)
		return FALSE

	set_active(TRUE)

	node_path_current_step = 1
	node_path_current = desired_path
	node_path_current_object = pathing_object
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

/ai/proc/set_path_astar(var/turf/destination,var/min_distance=0,var/atom/pathing_object)

	if(!destination)
		if(astar_path_current)
			frustration_astar_path = 0
			frustration_move = 0
			astar_path_current.Cut()
			astar_path_current = null
			astar_path_current_object = null
			obstacles.Cut()
		return TRUE

	if(master_ai)
		return FALSE

	set_active(TRUE)

	frustration_astar_path = 0
	frustration_move = 0
	var/list/returning_path = AStar_Circle(get_turf(owner),destination,owner,min_distance)
	if(returning_path)
		astar_path_current = returning_path
		astar_path_current_object = pathing_object
		set_active(TRUE)
		for(var/k in linked_ais)
			var/ai/A = k
			A.astar_path_current = returning_path.Copy()
			A.astar_path_current_object = astar_path_current_object
			A.set_active(TRUE)
		return TRUE
	else
		if(debug) log_debug("[src.get_debug_name()] tried astar pathing, but couldn't find a valid astar path.")

