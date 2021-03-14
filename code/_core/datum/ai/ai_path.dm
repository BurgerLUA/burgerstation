/ai/proc/set_path(var/list/Vector3D/desired_path = list())

	if(!desired_path || !length(desired_path))
		current_path = null
		path_start_turf = null
		path_end_turf = null
		path_steps = null
		frustration_path = 0
		return TRUE

	set_active(TRUE)

	path_steps = 1
	current_path = desired_path
	frustration_path = 0
	frustration_move = 0
	owner.move_dir = 0
	path_start_turf = get_turf(owner)

	var/Vector3D/last_path = desired_path[length(desired_path)]
	path_end_turf = locate(last_path.x,last_path.y,last_path.z)

	if(check_for_obstructions) check_obstructions()

	HOOK_CALL("set_path")

	return TRUE

/ai/proc/set_burger_star_path(var/turf/destination) //Very expensive.

	if(current_burger_star_path)
		current_burger_star_path.Cut()
		current_burger_star_path = null

	if(destination)
		var/list/returning_path = burger_star(owner,destination,TRUE)
		if(returning_path)
			current_burger_star_path = returning_path
			set_active(TRUE)
			return TRUE

	return FALSE