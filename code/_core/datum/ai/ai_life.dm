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
		var/objective_delay = get_objective_delay()
		if(objective_ticks >= objective_delay && !CALLBACK_EXISTS("set_new_objective_\ref[src]"))
			objective_ticks = 0
			if(objective_attack && frustration_attack < frustration_attack_threshold)
				handle_current_objectives(objective_delay)
			else
				find_new_objectives(objective_delay)
				frustration_attack = 0

			// Idle handler for when the above fails and the AI is being useless.
			if(sleep_on_idle)
				if(length(current_node_path) || objective_attack || objective_move || alert_level >= ALERT_LEVEL_NOISE)
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

	if(!owner.anchored && owner.next_move <= 0)
		if(!objective_attack && hunt_target && next_node_check_time <= world.time)
			next_node_check_time = world.time + SECONDS_TO_DECISECONDS(2)
			var/turf/desired_target_turf = get_step(hunt_target,turn(hunt_target.dir,180))
			if(!last_hunt_target_turf || get_dist(last_hunt_target_turf,desired_target_turf) >= hunt_distance)
				last_hunt_target_turf = desired_target_turf
				var/turf/current_turf = get_turf(owner)
				if(desired_target_turf && current_turf && desired_target_turf.z == current_turf.z)
					var/target_distance = get_dist(current_turf,desired_target_turf) //Get distance of the AI to the target.
					if(target_distance >= hunt_distance) //We're too far away. Lets find them.
						var/found_valid_path = FALSE
						if(target_distance >= VIEW_RANGE) //Wow we're really far away. Lets use a different pathing system instead.
							var/obj/marker/map_node/N_start = find_closest_node(current_turf) //Find the closest node to us.
							var/obj/marker/map_node/N_end = N_start ? find_closest_node(desired_target_turf) : null //Find the closet node to the target.
							var/list/obj/marker/map_node/found_path = N_end ? AStar_Circle_node(N_start,N_end) : null //Okay. Path time. Maybe.
							if(found_path)
								found_valid_path = set_path(found_path)
						if(!found_valid_path) //Couldn't find a valid path, so we use astar.
							set_path_astar(desired_target_turf)

		else if(use_pathfinding && frustration_move >= (length(current_path_astar) ? frustration_move_threshold*2 : frustration_move_threshold))
			var/path_num = length(current_node_path)
			if(path_num)
				set_path_astar(current_node_path[path_num])
			else if(objective_attack)
				set_path_astar(objective_attack)
			else if(objective_move)
				set_path_astar(objective_move)

		var/result = src.handle_movement()
		if(result)
			if(owner.has_status_effect(REST))
				owner.remove_status_effect(REST)
		else if(owner.next_move <= 0)
			owner.next_move = SECONDS_TO_DECISECONDS(2)
		if(!use_pathfinding && result && frustration_move >= frustration_move_threshold)
			owner.move_dir = turn(owner.move_dir,pick(-90,90,180))

	owner.handle_movement(tick_rate)

	return TRUE

/ai/proc/get_objective_delay() //In ticks.

	. = objective_delay

	if(objective_attack)
		. = max(.,SECONDS_TO_TICKS(4))

/ai/proc/on_death()
	set_objective(null)
	set_path(null)
	set_active(FALSE)
	return TRUE