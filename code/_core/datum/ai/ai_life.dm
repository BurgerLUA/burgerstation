/ai/proc/should_life()

	if(!active)
		return FALSE

	if(!owner)
		qdel(src)
		return FALSE

	if(!owner.finalized)
		return FALSE

	if(owner.dead)
		return FALSE

	if(!is_turf(owner.loc))
		return FALSE

	if(owner.has_status_effects(STUN,SLEEP,PARALYZE))
		return FALSE

	return TRUE

/ai/proc/on_life(var/tick_rate=1)

	if(owner.is_busy())
		return FALSE

	if(resist_grabs && owner.grabbing_hand && owner.next_resist <= world.time && (resist_grabs > 1 || is_enemy(owner.grabbing_hand.owner,FALSE)))
		owner.resist()
		return TRUE

	if(!passive)
		objective_ticks += tick_rate
		var/actual_objective_delay = get_objective_delay()
		if(objective_ticks >= actual_objective_delay && !CALLBACK_EXISTS("set_new_objective_\ref[src]"))
			objective_ticks = 0
			if(objective_attack && frustration_attack < frustration_attack_threshold)
				handle_current_objectives(actual_objective_delay)
			else
				find_new_objectives(actual_objective_delay)
				frustration_attack = 0

			// Idle handler for when the above fails and the AI is being useless.
			if(sleep_on_idle)
				if(length(node_path_current) || objective_attack || objective_move || alert_level >= ALERT_LEVEL_NOISE)
					idle_time = 0 //Reset idle.
				else
					if(idle_time <= 0)
						idle_time = world.time + SECONDS_TO_DECISECONDS(180) //Idle for more than 3 minutes means you're just wasting processing power.
					else if(idle_time <= world.time)
						var/found_player = FALSE
						for(var/k in all_players)
							var/mob/living/advanced/player/P = k
							if(P.z != owner.z)
								continue
							if(get_dist(P,owner) <= VIEW_RANGE)
								found_player = TRUE
								break
						if(found_player)
							idle_time = world.time + SECONDS_TO_DECISECONDS(180) //Try again later.
						else
							set_active(FALSE) //Deactivate if idle for more than 3 minutes.

		if(owner.attack_next <= world.time)
			handle_attacking()

	if(alert_level >= ALERT_LEVEL_NOISE && alert_level <= ALERT_LEVEL_CAUTION)
		alert_time -= tick_rate
		if(alert_time <= 0)
			set_alert_level(max(0,alert_level-1),TRUE)

	if(owner.anchored)
		return TRUE

	var/turf/current_turf
	var/should_remove_frustration = TRUE

	if(owner.next_move <= 0) //We will move.
		current_turf = get_turf(owner)

		if(!objective_attack && hunt_target && next_node_check_time <= world.time) //Update the hunt target destination.
			next_node_check_time = world.time + SECONDS_TO_DECISECONDS(2)
			var/turf/desired_target_turf = get_step(hunt_target,turn(hunt_target.dir,180))
			if(!last_hunt_target_turf || get_dist(last_hunt_target_turf,desired_target_turf) >= hunt_distance)
				last_hunt_target_turf = desired_target_turf
				if(desired_target_turf && current_turf && desired_target_turf.z == current_turf.z)
					var/target_distance = get_dist(current_turf,desired_target_turf) //Get distance of the AI to the target.
					if(target_distance >= hunt_distance) //We're too far away. Lets find them.
						var/found_valid_path = FALSE
						if(target_distance >= VIEW_RANGE) //Wow we're really far away. Lets use a different pathing system instead.
							var/obj/marker/map_node/N_start = find_closest_node(current_turf) //Find the closest node to us.
							var/obj/marker/map_node/N_end = N_start ? find_closest_node(desired_target_turf) : null //Find the closet node to the target.
							var/list/obj/marker/map_node/found_path = N_end ? AStar_Circle_node(N_start,N_end) : null //Okay. Path time. Maybe.
							if(found_path)
								found_valid_path = set_path_node(found_path)
						if(target_distance <= VIEW_RANGE*3 && !found_valid_path) //Couldn't find a valid path, so we use astar.
							set_path_astar(desired_target_turf)

		//Astar
		if(frustration_astar_path_threshold > 0 && length(astar_path_current) && frustration_astar_path > frustration_astar_path_threshold)
			frustration_astar_path = 0
			if(debug) log_debug("[src.get_debug_name()] trying to fallback path to last astar_path_current due to astar path failure...")
			set_path_fallback(astar_path_current[length(astar_path_current)])
		//Node
		else if(frustration_node_path_threshold > 0 && length(node_path_current) && frustration_node_path > frustration_node_path_threshold)
			frustration_node_path = 0
			if(debug) log_debug("[src.get_debug_name()] trying to fallback path to last node_path_current due to node path failure...")
			set_path_fallback(get_turf(node_path_current[length(node_path_current)]))
		//Move
		else if(use_astar_on_frustration_move && frustration_move_threshold > 0 && frustration_move > frustration_move_threshold)
			frustration_move = 0
			if(objective_attack)
				if(debug) log_debug("[src.get_debug_name()] trying to fallback path to objective_attack due to movement failure...")
				set_path_fallback(get_turf(objective_attack))
			else if(objective_move)
				if(debug) log_debug("[src.get_debug_name()] trying to fallback path to objective_move due to movement failure...")
				set_path_fallback(get_turf(objective_move))

		var/result = src.handle_movement()
		if(result && owner.move_dir)
			if(owner.has_status_effect(REST))
				owner.remove_status_effect(REST)
			var/threshold_to_use = use_astar_on_frustration_move ? frustration_move_threshold*0.5 : frustration_move_threshold
			if(frustration_move_threshold > 0 && frustration_move > threshold_to_use) //Bad movement.
				owner.move_dir = turn(owner.move_dir,pick(-90,90,180))
				should_remove_frustration = FALSE
		else
			owner.next_move = max(owner.next_move,SECONDS_TO_TICKS(1)) //Wait a bit.
			owner.move_dir = 0x0 //Prevents frustration from running.

		if(owner.move_dir && current_turf.is_safe())
			var/turf/T = get_step(owner,owner.move_dir)
			if(!T.is_safe())
				owner.move_dir = 0x0
				frustration_move = frustration_move_threshold
				frustration_node_path = frustration_node_path_threshold
				frustration_astar_path = frustration_astar_path_threshold
				should_remove_frustration = FALSE

	owner.handle_movement(tick_rate)

	if(owner.move_dir && current_turf) //current_turf will only be assigned if they were supposed to move.
		if(current_turf == get_turf(owner)) //Did not move even though it was supposed to move.
			if(length(astar_path_current))
				if(frustration_astar_path_threshold > 0) frustration_astar_path++
			else if(length(node_path_current))
				if(frustration_node_path_threshold > 0) frustration_node_path++
			else if(frustration_move_threshold)
				frustration_move++
			if(debug) log_debug("[src.get_debug_name()] tried moving, but couldn't.")
		else if(should_remove_frustration)
			if(length(astar_path_current))
				if(frustration_astar_path_threshold > 0) frustration_astar_path_threshold = max(0,frustration_astar_path_threshold-1)
			else if(length(node_path_current))
				if(frustration_node_path_threshold > 0) frustration_node_path_threshold = max(0,frustration_node_path_threshold-1)
			else if(frustration_move_threshold)
				frustration_move = max(0,frustration_move-1)


	return TRUE

/ai/proc/get_objective_delay() //In ticks.

	. = objective_delay

	if(objective_attack)
		. = max(.,SECONDS_TO_TICKS(4))

/ai/proc/on_death()
	set_objective(null)
	set_path_node(null)
	set_path_astar(null)
	set_active(FALSE)
	return TRUE