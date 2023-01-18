
/ai/proc/post_move(var/mob/living/L,args)

	var/atom/old_loc = args[1]

	var/turf/old_turf = get_turf(old_loc)
	var/turf/new_turf = get_turf(L.loc)

	if(new_turf?.z != old_turf?.z)
		if(active)
			if(old_turf) remove_from_active_list(old_turf.z)
			if(new_turf) add_to_active_list(new_turf.z)
		else
			if(old_turf) remove_from_inactive_list(old_turf.z)
			if(new_turf) add_to_inactive_list(new_turf.z)

	return TRUE

/ai/proc/set_move_objective(var/atom/desired_objective,var/follow = FALSE,var/astar = FALSE) //Set follow to true if it should constantly follow the person.
	if(desired_objective)
		set_active(TRUE)
	objective_move = desired_objective
	should_follow_objective_move = follow
	should_astar_objective_move = astar
	frustration_move = 0
	return TRUE

/ai/proc/handle_movement_attack_objective()

	if(objective_attack)

		if(cowardice > 0)
			var/health_percent = owner.health ? owner.health.health_current/owner.health.health_max : 1
			if((owner.horizontal || health_percent <= cowardice) && !length(node_path_current) && !length(astar_path_current) && get_dist(owner,objective_attack) <= VIEW_RANGE)
				owner.move_dir = get_dir(objective_attack,owner)
				owner.movement_flags = MOVEMENT_RUNNING
				/* TOO EXPENSIVE
				var/turf/T1 = get_turf(owner)
				var/turf/T2 = get_turf(objective_attack)
				var/list/offsets = get_directional_offsets(T2,T1)
				if(!offsets[1] && !offsets[2])
					offsets[1] = pick(-1,1)
					offsets[2] = pick(-1,1)
				var/final_x = T1.x + offsets[1]*VIEW_RANGE*3
				final_x = clamp(final_x,1,world.maxx)
				var/final_y = T1.y + offsets[2]*VIEW_RANGE*3
				final_y = clamp(final_y,1,world.maxy)
				var/turf/final_turf  = locate(final_x,final_y,T1.z)
				if(final_turf)
					if(!set_path_fallback(final_turf))
						cowardice = 0
				*/
				return TRUE

		if(!objective_attack.z) //Inside something. Get close to it.
			owner.move_dir = get_dir(owner,get_turf(objective_attack))
			owner.movement_flags = MOVEMENT_RUNNING
			return TRUE

		var/target_distance = get_dist(owner,objective_attack)
		if(attack_distance_min > 0 && target_distance < attack_distance_min) //Get farther to attack.
			owner.move_dir = get_dir(objective_attack,owner)
			owner.movement_flags = MOVEMENT_NORMAL
		else if(target_distance > attack_distance_max) //Get closer to attack.
			owner.move_dir = get_dir(owner,objective_attack)
			owner.movement_flags = MOVEMENT_RUNNING
		else
			owner.movement_flags = MOVEMENT_NORMAL
			if(prob(target_distance <= 1 ? 25 : 5)) //Strafe when close.
				owner.move_dir = turn(get_dir(owner,objective_attack),pick(-90,90))

		return TRUE

	return FALSE

/ai/proc/handle_movement_move_objective()

	if(objective_move)
		var/move_distance = get_dist(owner,objective_move)
		if(move_distance >= VIEW_RANGE*0.75 && should_astar_objective_move)
			if(!set_path_astar(get_turf(objective_move)))
				set_move_objective(null)
		else if(move_distance > 1)
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

/ai/proc/check_node_path_obstructions()

	if(length(node_path_current) < node_path_current_step)
		return FALSE

	if(!node_path_current[node_path_current_step])
		return FALSE

	var/obj/marker/map_node/desired_node = node_path_current[node_path_current_step]
	var/turf/T1 = get_turf(owner)
	var/list/obstructions = get_obstructions(T1,desired_node,ignore_living=TRUE)

	if(!length(obstructions)) //All good.
		return TRUE

	var/turf/T2 = locate(desired_node.x,desired_node.y,desired_node.z)

	if(set_path_astar(T2)) //Okay we found obstructions, but can we path through it?
		return TRUE

	for(var/k in obstructions) //Can't path though it, so we destroy it.
		var/atom/A = k
		if(!A.can_be_attacked(owner)) //Can't even destroy it. Just give up.
			obstacles.Cut()
			set_path_node(null)
			break //Give up.
		obstacles[A] = TRUE

	return TRUE


/ai/proc/handle_movement_astar()

	if(length(astar_path_current))
		var/turf/T = get_turf(owner)
		var/turf/desired_turf = astar_path_current[1]
		if(T == desired_turf)
			astar_path_current -= desired_turf
			if(length(astar_path_current))
				desired_turf = astar_path_current[1]
			else
				desired_turf = null
		if(desired_turf)
			owner.move_dir = get_dir(owner,desired_turf)
		else
			owner.move_dir = 0x0
			set_path_astar(null)
		return TRUE

	return FALSE

/ai/proc/handle_movement_path()
	if(length(node_path_current))
		if(node_path_current_step <= length(node_path_current))
			var/obj/marker/map_node/desired_node = node_path_current[node_path_current_step]
			var/desired_precision = desired_node.precision
			if(node_path_current_step - 1 >= 1)
				var/obj/marker/map_node/last_node = node_path_current[node_path_current_step-1]
				desired_precision = min(desired_precision,last_node.precision)
			var/turf/T = get_turf(owner)
			var/calc_distance = abs(desired_node.x - T.x) + abs(desired_node.y - T.y)
			if(calc_distance <= desired_precision) //We've made it to the next node.
				node_path_current_step++
				owner.move_dir = 0
				if(check_for_obstructions) check_node_path_obstructions()
				frustration_node_path = 0
			else
				owner.move_dir = get_dir(owner,locate(desired_node.x,desired_node.y,desired_node.z))
		else //Complete path
			if(!guard)
				home_turf = get_turf(owner)
			set_path_node(null)
			owner.move_dir = 0
		return TRUE
	return FALSE

/ai/proc/handle_movement_roaming()

	if(roaming_distance > 0)

		var/start_turf_distance = get_dist(owner,home_turf)

		if(roaming_direction) //Currently romaing
			if(start_turf_distance == roaming_distance || roaming_counter <= 0) //Stop roaming. Too far.
				roaming_direction = 0x0
			else if(start_turf_distance > roaming_distance)
				owner.movement_flags = MOVEMENT_WALKING
				owner.move_dir = get_dir(owner,home_turf)
			else
				owner.movement_flags = MOVEMENT_WALKING
				owner.move_dir = roaming_direction
				if(prob(20))
					roaming_direction = turn(roaming_direction,45)
				roaming_counter -= 1
				return TRUE
		else //Not roaming
			if(prob(5)) //Now roaming
				var/list/valid_directions = DIRECTIONS_ALL
				var/bad_direction = get_dir(home_turf,owner)
				valid_directions -= bad_direction
				valid_directions -= turn(bad_direction,45)
				valid_directions -= turn(bad_direction,-45)
				roaming_direction = pick(valid_directions)
				roaming_counter = roaming_distance*2
				if(allow_far_roaming && !guard)
					home_turf = get_turf(owner)

	return FALSE

/ai/proc/handle_movement_guarding()

	if(!guard || !home_turf)
		return FALSE

	var/turf/T = get_turf(owner)

	if(T.z == home_turf.z)

		if(T == home_turf)
			var/turf/facing_turf = get_step(owner,owner.dir)
			if(facing_turf.density || prob(4))
				owner.set_dir(turn(owner.dir,pick(-90,90)))
			return FALSE

		if(!objective_move)
			var/list/obstructions = get_obstructions(T,home_turf)
			if(!length(obstructions))
				objective_move = home_turf
			else if(!set_path_astar(home_turf))
				guard = FALSE
				return FALSE

	else
		guard = FALSE
		return FALSE


	//We don't return true here because we really want this to be overwritten.

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

/ai/proc/handle_movement_loc_safety()
	if(enable_loc_safety && !is_turf(owner.loc))
		owner.movement_flags = MOVEMENT_NORMAL
		owner.move_dir = pick(DIRECTIONS_ALL)
		return TRUE
	return FALSE

/ai/proc/handle_movement_reset()
	owner.movement_flags = MOVEMENT_NORMAL
	owner.move_dir = 0x0
	return TRUE

/ai/proc/handle_movement_move_from_ally()

	if(move_from_ally <= 0)
		return FALSE

	owner.move_dir = move_from_ally_dir
	move_from_ally--

	return TRUE

/ai/proc/handle_movement()

	if(handle_movement_loc_safety())
		last_movement_proc = "loc_safety"
		return TRUE

	if(handle_movement_move_from_ally())
		last_movement_proc = "move_from_ally"
		return TRUE

	if(handle_movement_astar())
		last_movement_proc = "astar"
		return TRUE

	if(handle_movement_path())
		last_movement_proc = "path"
		return TRUE

	if(handle_movement_attack_objective())
		last_movement_proc = "attack_objective"
		return TRUE

	if(handle_movement_move_objective())
		last_movement_proc = "move_objective"
		return TRUE

	if(handle_movement_alert())
		last_movement_proc = "alert"
		return TRUE

	if(handle_movement_guarding())
		last_movement_proc = "guarding"
		return TRUE

	if(handle_movement_roaming())
		last_movement_proc = "roaming"
		return TRUE

	handle_movement_reset()
	last_movement_proc = "none"

	return FALSE

/ai/proc/Bump(var/atom/obstacle,var/trigger_other_bump=TRUE)

	if(obstacle)
		if(is_living(obstacle))
			var/mob/living/L = obstacle
			if(is_enemy(L))
				set_alert_level(ALERT_LEVEL_CAUTION,FALSE,L,L)
				spawn do_attack(obstacle,prob(left_click_chance))
			else
				move_from_ally = 3 //Excuse me, Dr. Freeman.
				move_from_ally_dir = L.move_dir
				if(!move_from_ally_dir)
					if(owner.move_dir)
						move_from_ally_dir = turn(owner.move_dir,180)
					else
						move_from_ally_dir = pick(DIRECTIONS_ALL)
				trigger_other_bump = FALSE
			if(trigger_other_bump && L.ai)
				L.ai.Bump(owner,FALSE)
		else if(attack_movement_obstructions)
			spawn do_attack(obstacle,prob(left_click_chance))



	return TRUE