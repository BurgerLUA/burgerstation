/ai/proc/can_enter_turf(var/turf/T)

	if(!ignore_hazard_turfs && istype(T,/turf/simulated/hazard/))
		return FALSE

	return TRUE

/ai/proc/post_move(var/mob/living/L,args)

	var/atom/old_loc = args[1]

	var/turf/old_turf = get_turf(old_loc)
	var/turf/new_turf = get_turf(L.loc)

	if(old_turf && new_turf)
		if(old_turf == new_turf)
			frustration_move++
			if(length(current_path))
				frustration_path++
			if(frustration_move >= frustration_move_threshold)
				sidestep_next = TRUE
				frustration_move = 0
			if(debug) log_debug("[src.get_debug_name()] post_move'd to the same loc")
		else
			frustration_move = 0
			if(debug) log_debug("[src.get_debug_name()] post_move'd to a different loc.")

	if(!new_turf || new_turf.z != last_z)
		if(active)
			if(last_z) remove_from_active_list(last_z)
			if(new_turf) add_to_active_list(new_turf.z)
		else
			if(last_z) remove_from_inactive_list(last_z)
			if(new_turf) add_to_inactive_list(new_turf.z); set_active(TRUE) //Wake up the AI if we can.
		if(new_turf) last_z = new_turf.z

	return TRUE

/ai/proc/set_move_objective(var/atom/desired_objective,var/follow = FALSE) //Set follow to true if it should constantly follow the person.
	if(desired_objective)
		set_active(TRUE)
	objective_move = desired_objective
	should_follow_objective_move = follow
	return TRUE

/ai/proc/handle_movement_attack_objective()

	if(objective_attack)
		var/target_distance = get_dist(owner,objective_attack)
		if(target_distance < attack_distance_min)
			owner.move_dir = get_dir(objective_attack,owner)
			owner.movement_flags = MOVEMENT_RUNNING
		if(target_distance > attack_distance_max)
			owner.move_dir = get_dir(owner,objective_attack)
			owner.movement_flags = MOVEMENT_RUNNING
		else
			owner.movement_flags = MOVEMENT_NORMAL
			if(prob(target_distance <= 1 ? 25 : 5))
				owner.move_dir = pick(turn(get_dir(owner,objective_attack),90),turn(get_dir(owner,objective_attack),-90))
		return TRUE

	return FALSE

/ai/proc/handle_movement_move_objective()
	if(objective_move)
		var/move_distance = get_dist(owner,objective_move)
		if(move_distance > 1)
			if(should_follow_objective_move && move_distance >= 4)
				owner.movement_flags = MOVEMENT_RUNNING
			else
				owner.movement_flags = MOVEMENT_NORMAL
			owner.move_dir = get_dir(owner,objective_move)
		else
			if(!should_follow_objective_move)
				set_move_objective(null)
			owner.movement_flags = MOVEMENT_NORMAL
			owner.move_dir = 0x0
		return TRUE
	return FALSE

/ai/proc/check_obstructions()

	if(length(current_path) < path_steps)
		return FALSE

	if(!current_path[path_steps])
		return FALSE

	var/Vector3D/desired_node = current_path[path_steps]
	var/turf/T1 = get_turf(owner)
	var/turf/T2 = locate(desired_node.x,desired_node.y,desired_node.z)
	var/list/obstructions = get_obstructions(T1,T2)

	for(var/k in obstructions)
		var/atom/A = k
		if(!A.health) //Can't destroy.
			obstacles.Cut()
			set_path(null)
			break
		obstacles[A] = TRUE

	return TRUE

/*
/ai/proc/handle_movement_burger_star()

	if(current_burger_star_path && length(current_burger_star_path))
		owner.movement_flags = MOVEMENT_NORMAL
		var/turf/T = get_turf(owner)
		var/turf/desired_turf = current_burger_star_path[1]
		if(T == desired_turf)
			current_burger_star_path -= desired_turf
			if(length(current_burger_star_path))
				desired_turf = current_burger_star_path[1]
			else
				desired_turf = null
		if(desired_turf)
			owner.move_dir = get_dir(owner,desired_turf)
		else
			owner.move_dir = 0x0
			set_burger_star_path(null)
		return TRUE

	return FALSE
*/


/ai/proc/handle_movement_path()
	if(current_path && length(current_path))
		owner.movement_flags = MOVEMENT_NORMAL
		if(path_steps <= length(current_path))
			var/Vector3D/desired_node = current_path[path_steps]
			var/turf/T = get_turf(owner)
			if(desired_node.x == T.x && desired_node.y == T.y)
				path_steps++
				owner.move_dir = 0
				if(check_for_obstructions) check_obstructions()
				frustration_path = 0
			else
				owner.move_dir = get_dir(owner,locate(desired_node.x,desired_node.y,desired_node.z))
		else //Complete path
			start_turf = get_turf(owner)
			set_path(null)
			owner.move_dir = 0
		return TRUE
	return FALSE

/ai/proc/handle_movement_path_frustration()

	if(frustration_path > frustration_path_threshold)

		frustration_path = 0

		var/obj/marker/map_node/N_start = find_closest_node(owner,check_view=TRUE)
		if(!N_start)
			set_path(null)
			if(delete_on_no_path)
				queue_delete(owner,0,TRUE)
			else
				SSai.path_stuck_ai |= src
			return FALSE

		var/obj/marker/map_node/N_end = find_closest_node(path_end_turf)
		if(!N_end)
			log_error("[owner] ([owner.x],[owner.y],[owner.z]) is stuck and cannot find a path end!")
			set_path(null)
			if(delete_on_no_path)
				queue_delete(owner,0,TRUE)
			else
				SSai.path_stuck_ai |= src
			return FALSE

		var/list/obj/marker/map_node/found_path = N_start.find_path(N_end)
		if(!found_path)
			log_error("[owner] ([owner.x],[owner.y],[owner.z]) is stuck and cannot find a final path!")
			set_path(null)
			if(delete_on_no_path)
				queue_delete(owner,0,TRUE)
			else
				SSai.path_stuck_ai |= src
			return FALSE

		//set_burger_star_path(get_turf(N_start))
		set_path(found_path)

		return TRUE

	return FALSE

/ai/proc/handle_movement_roaming()
	if(roaming_distance)
		if(get_dist(owner,start_turf) >= roaming_distance)
			owner.movement_flags = MOVEMENT_WALKING
			owner.move_dir = get_dir(owner,start_turf)
			return TRUE
		else
			if(roam)
				if(prob(5))
					owner.movement_flags = MOVEMENT_WALKING
					owner.move_dir = pick(DIRECTIONS_ALL)
					roam_counter -= 1
			else
				owner.movement_flags = MOVEMENT_WALKING
				owner.move_dir = 0x0
				if(prob(25))
					roam_counter -= 1
			if(roam_counter <= 0)
				roam = !roam
				roam_counter = initial(roam_counter)

	return FALSE

/ai/proc/handle_movement_alert()

	if(alert_level > ALERT_LEVEL_NONE && objective_investigate)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = get_dir(owner,objective_investigate)
		return TRUE

	else if(alert_level == ALERT_LEVEL_CAUTION)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = pick(list(0,0,0,0,NORTH,EAST,SOUTH,WEST))
		return TRUE

	return FALSE

/ai/proc/handle_movement_sidestep()

	if(sidestep_next)
		if(!owner.move_dir)
			owner.move_dir = pick(DIRECTIONS_INTERCARDINAL)

		if(prob(50))
			var/move_cone = pick(45,90)
			owner.move_dir = turn(owner.dir,pick(-move_cone,move_cone))
		else
			owner.move_dir = turn(owner.dir,180)
		sidestep_next = FALSE
		frustration_move = 0
		return TRUE

	return FALSE

/ai/proc/handle_movement_reset()
	owner.movement_flags = MOVEMENT_NORMAL
	owner.move_dir = 0x0
	return TRUE

/ai/proc/handle_movement()

	/*
	if(handle_movement_burger_star())
		return TRUE
	*/

	if(handle_movement_sidestep())
		return TRUE

	if(handle_movement_path_frustration())
		return TRUE

	if(handle_movement_attack_objective())
		return TRUE

	if(handle_movement_move_objective())
		return TRUE

	if(handle_movement_alert())
		return TRUE

	if(handle_movement_path())
		return TRUE

	if(handle_movement_roaming())
		return TRUE

	handle_movement_reset()

	return FALSE

/ai/proc/Bump(var/atom/obstacle,var/trigger_other_bump=TRUE)

	if(obstacle && is_living(obstacle))
		var/mob/living/L = obstacle
		if(is_enemy(L))
			set_alert_level(ALERT_LEVEL_CAUTION,FALSE,L,L)
			if(attack_on_block)
				spawn do_attack(obstacle,prob(left_click_chance))

		if(trigger_other_bump && L.ai)
			L.ai.Bump(owner,FALSE)

	return TRUE