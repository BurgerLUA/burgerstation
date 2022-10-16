/ai/proc/set_path(var/list/obj/marker/map_node/desired_path = list())

	if(!desired_path || !length(desired_path))
		current_node_path = null
		path_start_turf = null
		path_end_turf = null
		path_steps = null
		frustration_path = 0
		return TRUE

	set_active(TRUE)

	path_steps = 1
	current_node_path = desired_path
	frustration_path = 0
	frustration_move = 0
	owner.move_dir = 0
	path_start_turf = get_turf(owner)

	var/obj/marker/map_node/last_node = current_node_path[length(current_node_path)]
	path_end_turf = locate(last_node.x,last_node.y,last_node.z)

	if(check_for_obstructions) check_node_path_obstructions()

	if(debug)
		for(var/k in desired_path)
			var/obj/marker/map_node/MN = k
			MN.alpha = 255
			MN.invisibility = 0

	HOOK_CALL("set_path")

	return TRUE

/ai/proc/set_path_astar(var/turf/destination,var/min_distance=0)

	if(current_path_astar)
		current_path_astar.Cut()
		current_path_astar = null

	if(destination)
		var/list/returning_path = AStar_Circle(get_turf(owner),destination,owner,min_distance)
		if(returning_path)
			current_path_astar = returning_path
			set_active(TRUE)
			return TRUE

	return FALSE