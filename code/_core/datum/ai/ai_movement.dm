
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

/ai/proc/set_move_objective(var/atom/desired_objective,var/distance=0,var/astar = FALSE,var/follow = FALSE) //Set follow to true if it should constantly follow the person.
	if(desired_objective)
		set_active(TRUE)
	objective_move = desired_objective
	should_follow_objective_move = follow
	should_astar_objective_move = astar
	objective_move_distance = distance
	frustration_move = 0
	return TRUE


/ai/proc/handle_movement_cowardice()

	if(!objective_attack)
		return FALSE

	if(cowardice >= 0) //RUN AWAY.
		var/health_percent = owner.health ? owner.health.health_current/owner.health.health_max : 1
		if((owner.horizontal || health_percent <= cowardice) && !length(node_path_current) && !length(astar_path_current) && get_dist(owner,objective_attack) <= VIEW_RANGE)
			owner.move_dir = get_dir(objective_attack,owner)
			owner.movement_flags = MOVEMENT_RUNNING
			return TRUE

	return FALSE


/ai/proc/handle_movement_attack_objective()

	if(!objective_attack)
		return FALSE

	if(!objective_attack.z) //They're inside something. Get close to it.
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

/ai/proc/handle_movement_move_objective()

	if(!objective_move || objective_attack) //Only move if you actually have an objective, and you don't have an objective attack.
		return FALSE

	var/turf/T = get_turf(objective_move)
	var/move_distance = get_dist(owner,T)

	if(move_distance <= max(1,objective_move_distance)) //We're close, so we can stop following them.
		if(!should_follow_objective_move)
			set_move_objective(null)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = 0x0
		return TRUE

	if(should_astar_objective_move) //Astar objective following. Makes sure there is no redundent pathing.
		var/astar_length = length(astar_path_current)
		var/should_path = TRUE
		if(astar_length && get_dist(astar_path_current[astar_length],objective_move) < 2)
			should_path = FALSE
		var/node_length = length(node_path_current)
		if(node_length && get_dist(node_path_current[node_length],objective_move) < VIEW_RANGE*0.5)
			should_path = FALSE
		if(should_path && !set_path_fallback(T,pathing_object=objective_move))
			set_move_objective(null) //Failure. Can't get there.
			return FALSE

	owner.move_dir = get_dir(owner,objective_move)
	if(should_follow_objective_move && move_distance >= 4)
		owner.movement_flags = MOVEMENT_RUNNING
	else
		owner.movement_flags = MOVEMENT_NORMAL

	return TRUE

/ai/proc/handle_movement_astar()

	if(!length(astar_path_current))
		return FALSE

	var/turf/current_turf = get_turf(owner)

	if(astar_path_current_object)
		var/turf/object_turf = get_turf(astar_path_current_object)
		if(object_turf)
			var/current_distance = get_dist(current_turf,object_turf)
			if(current_distance <= astar_path_current_object_sensitivity_min)
				set_path_astar(null)
				return FALSE
			else if(current_distance >= astar_path_current_object_sensitivity_max)
				set_path_astar(object_turf,pathing_object=astar_path_current_object)
				if(!length(astar_path_current))
					return FALSE

	var/turf/desired_turf = astar_path_current[1]
	if(current_turf == desired_turf)
		astar_path_current.Cut(1,2)
		if(length(astar_path_current))
			desired_turf = astar_path_current[1]
		else
			desired_turf = null

	if(desired_turf)
		owner.move_dir = get_dir(owner,desired_turf)
		return TRUE

	set_path_astar(null)
	return FALSE



/ai/proc/handle_movement_path()

	if(!length(node_path_current))
		return FALSE

	if(node_path_current_step > length(node_path_current))
		if(!guard)
			home_turf = get_turf(owner)
		set_path_node(null)
		owner.move_dir = 0x0
		return TRUE

	var/obj/marker/map_node/desired_node = node_path_current[node_path_current_step]
	var/desired_precision = desired_node.precision

	if(node_path_current_step - 1 >= 1) //Get the last node, if there is one.
		var/obj/marker/map_node/last_node = node_path_current[node_path_current_step-1]
		desired_precision = min(desired_precision,last_node.precision) //Set the precision to the smallest amount.

	var/turf/T_owner = get_turf(owner)
	var/turf/T_node = get_turf(desired_node)
	var/calc_distance = get_dist(T_owner,T_node)
	if(calc_distance <= desired_precision) //We've made it to the next node. Wait for next movement.
		node_path_current_step++
		owner.move_dir = 0x0
		if(check_for_obstructions) check_node_path_obstructions()
		frustration_node_path = 0
	else
		owner.move_dir = get_dir(T_owner,T_node)

	return TRUE

/ai/proc/handle_movement_roaming()

	if(roaming_distance <= 0)
		return FALSE

	var/start_turf_distance = get_dist(owner,home_turf)

	if(!roaming_direction) //Not roaming.
		if(!prob(5)) //Failed the chance to roam.
			return FALSE
		//Roam chance success.
		var/list/valid_directions = DIRECTIONS_ALL
		var/bad_direction = get_dir(home_turf,owner)
		valid_directions -= bad_direction
		valid_directions -= turn(bad_direction,45)
		valid_directions -= turn(bad_direction,-45)
		roaming_direction = pick(valid_directions)
		roaming_counter = roaming_distance*2
		if(allow_far_roaming && !guard)
			home_turf = get_turf(owner)

	if(start_turf_distance == roaming_distance || roaming_counter <= 0) //Stop roaming. Too far.
		roaming_direction = 0x0
		return FALSE

	if(start_turf_distance > roaming_distance)
		owner.movement_flags = MOVEMENT_WALKING
		owner.move_dir = get_dir(owner,home_turf)
		return TRUE

	owner.movement_flags = MOVEMENT_WALKING
	owner.move_dir = roaming_direction
	if(prob(20))
		roaming_direction = turn(roaming_direction,45)
	roaming_counter -= 1

	return TRUE

/ai/proc/handle_movement_guarding()

	if(!guard || !home_turf)
		return FALSE

	var/turf/T = get_turf(owner)

	if(T.z != home_turf.z)
		guard = FALSE //Failure.
		return FALSE

	if(T == home_turf) //We're here.
		var/turf/facing_turf = get_step(owner,owner.dir)
		if(facing_turf.density || prob(4))
			owner.set_dir(turn(owner.dir,pick(-90,90)))
		return FALSE //Avoid canceling other movement procs.

	if(!set_path_fallback(home_turf))
		guard = FALSE
		return FALSE

	return TRUE

/ai/proc/handle_movement_alert() //Moving around randomly.

	if(alert_level <= ALERT_LEVEL_NONE)
		return FALSE

	if(alert_movement_latch)
		if(prob(33))
			alert_movement_latch = 0x0
	else
		if(!prob(80))
			alert_movement_latch = pick(DIRECTIONS_CARDINAL)

	owner.movement_flags = MOVEMENT_WALKING
	owner.move_dir = alert_movement_latch

	return TRUE

/ai/proc/handle_movement_loc_safety() //Moving out of closets.
	if(!enable_loc_safety || is_turf(owner.loc))
		return FALSE
	owner.movement_flags = MOVEMENT_NORMAL
	owner.move_dir = pick(DIRECTIONS_ALL)
	return TRUE


/ai/proc/handle_movement_reset()
	owner.movement_flags = MOVEMENT_NORMAL
	owner.move_dir = 0x0
	return TRUE

/ai/proc/handle_movement_move_from_ally()

	if(boss || move_from_ally <= 0)
		return FALSE

	owner.move_dir = move_from_ally_dir
	move_from_ally--

	return TRUE

/ai/proc/handle_movement()

	if(handle_movement_cowardice())
		last_movement_proc = "cowardice"
		return TRUE

	if(handle_movement_loc_safety())
		last_movement_proc = "loc_safety"
		return TRUE

	if(handle_movement_move_from_ally())
		last_movement_proc = "move_from_ally"
		return TRUE

	if(handle_movement_move_objective())
		last_movement_proc = "move_objective"
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

	if(!obstacle)
		return TRUE

	if(is_living(obstacle))
		var/mob/living/L = obstacle
		if(is_enemy(L))
			if(objective_attack && can_attack)
				spawn do_attack(obstacle,prob(left_click_chance))
			else
				set_alert_level(ALERT_LEVEL_CAUTION,L)
		else
			move_from_ally = rand(0,3) //Excuse me, Dr. Freeman.
			move_from_ally_dir = L.move_dir ? turn(L.move_dir,pick(-45,0,45)) : 0x0
			if(!move_from_ally_dir)
				if(owner.move_dir)
					move_from_ally_dir = turn(owner.move_dir,pick(180-45,180,180+45))
				else
					move_from_ally_dir = pick(DIRECTIONS_ALL)
			trigger_other_bump = FALSE
		if(trigger_other_bump && L.ai)
			L.ai.Bump(owner,FALSE)
	else if(attack_movement_obstructions && can_attack && objective_attack)
		spawn do_attack(obstacle,prob(left_click_chance))

	return TRUE

//We basically check if we can path between each node.
/ai/proc/check_node_path_obstructions()

	if(length(node_path_current) < node_path_current_step)
		return FALSE

	if(!node_path_current[node_path_current_step])
		return FALSE

	obstacles.Cut() //Remove previous obstructions

	var/obj/marker/map_node/desired_node = node_path_current[node_path_current_step]
	var/turf/T1 = get_turf(owner)
	var/list/obstructions = get_obstructions(T1,desired_node,ignore_living=TRUE)

	if(!length(obstructions)) //All good.
		return TRUE

	var/turf/T2 = locate(desired_node.x,desired_node.y,desired_node.z)

	if(set_path_astar(T2)) //Okay we found obstructions, but we can path through it.
		return TRUE

	for(var/k in obstructions) //Can't path though it, so we destroy it.
		var/atom/A = k
		if(!A.can_be_attacked(owner)) //Can't even destroy it. Just give up.
			set_path_node(null)
			break //Give up.
		obstacles[A] = TRUE

	//DEBUG STUFF
	if(objective_attack && is_player(objective_attack))
		objective_attack << "Obstacles: [obstacles]."


	return length(obstacles)
