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

	if(aggression > 0)
		if(!master_ai) //Find objectives only if you don't belong to a master.
			objective_ticks += tick_rate
			var/actual_objective_delay = get_objective_delay()
			if(objective_ticks >= actual_objective_delay && !CALLBACK_EXISTS("set_new_objective_\ref[src]"))
				objective_ticks = 0
				if(objective_attack && frustration_attack < frustration_attack_threshold)
					if(handle_current_objectives(actual_objective_delay) && !is_living(objective_attack))
						find_new_objectives(actual_objective_delay) //Try to find new objectives if we're attacking something non-living.
				else
					find_new_objectives(actual_objective_delay)
					frustration_attack = 0

		if(owner.attack_next <= world.time)
			handle_attacking()

	// Idle handler for when the AI is being useless.
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


	if(alert_level >= ALERT_LEVEL_NOISE)
		var/time_mod = 1
		switch(alert_level)
			if(ALERT_LEVEL_NOISE)
				time_mod = 1
			if(ALERT_LEVEL_CAUTION)
				time_mod = 0.5
			if(ALERT_LEVEL_COMBAT)
				time_mod = 0.25
		alert_time -= tick_rate*time_mod
		if(alert_time <= 0)
			set_alert_level(max(0,alert_level-1),can_lower=TRUE)

	if(owner.anchored)
		return TRUE

	var/turf/current_turf
	var/should_remove_frustration = TRUE

	if(owner.next_move <= 0) //We will move.
		current_turf = get_turf(owner)

		if(!master_ai) //No frustration handling if you belong to a master.

			//Update the hunt target destination.
			if(!objective_attack && hunt_target && next_node_check_time <= world.time)
				next_node_check_time = world.time + SECONDS_TO_DECISECONDS(4)
				var/turf/possible_turf_01 = get_turf(hunt_target)
				var/turf/possible_turf_02 = get_step(possible_turf_01,turn(hunt_target.dir,180))
				var/turf/desired_target_turf = possible_turf_02 && !possible_turf_02.has_dense_atom ? possible_turf_02 : possible_turf_01
				if(!last_hunt_target_turf || get_dist(last_hunt_target_turf,desired_target_turf) >= hunt_distance)
					last_hunt_target_turf = desired_target_turf
					if(desired_target_turf && current_turf && desired_target_turf.z == current_turf.z)
						var/target_distance = get_dist(current_turf,desired_target_turf) //Get distance of the AI to the target.
						if(target_distance >= hunt_distance) //We're too far away. Lets find them.
							set_path_fallback(desired_target_turf) // We don't include pathing_object=hunt_target here for performance reasons.

			//Astar path sanity.
			if(frustration_astar_path_threshold > 0 && length(astar_path_current) && frustration_astar_path > frustration_astar_path_threshold)
				frustration_astar_path = 0
				if(debug) log_debug("[src.get_debug_name()] trying to fallback path to last astar_path_current due to astar path failure...")
				set_path_fallback(astar_path_current[length(astar_path_current)])
			//Node path sanity.
			else if(frustration_node_path_threshold > 0 && length(node_path_current) && frustration_node_path > frustration_node_path_threshold)
				frustration_node_path = 0
				if(debug) log_debug("[src.get_debug_name()] trying to fallback path to last node_path_current due to node path failure...")
				set_path_fallback(get_turf(node_path_current[length(node_path_current)]))
			//Move
			else if(use_astar_on_frustration_move && frustration_move_threshold > 0 && frustration_move > frustration_move_threshold)
				frustration_move = 0
				if(objective_attack)
					if(debug) log_debug("[src.get_debug_name()] trying to fallback path to objective_attack due to movement failure...")
					set_path_fallback(get_turf(objective_attack),pathing_object=objective_attack)
				else if(objective_move)
					if(debug) log_debug("[src.get_debug_name()] trying to fallback path to objective_move due to movement failure...")
					set_path_fallback(get_turf(objective_move),pathing_object=objective_move)

		var/result = src.handle_movement()
		if(result && owner.move_dir)
			if(owner.has_status_effect(REST))
				owner.remove_status_effect(REST)
			if(sidestep_on_frustration_move)
				var/threshold_to_use = use_astar_on_frustration_move ? frustration_move_threshold*0.5 : frustration_move_threshold
				if(frustration_move_threshold > 0 && frustration_move > threshold_to_use) //Bad movement.
					owner.move_dir = turn(owner.move_dir,pick(-90,90,180))
					should_remove_frustration = FALSE
		else
			owner.next_move = max(owner.next_move,SECONDS_TO_TICKS(1)) //Wait a bit.
			owner.move_dir = 0x0 //Prevents frustration from running.

		//Handle safety checks for movement.
		if(owner.move_dir && current_turf.is_safe())
			var/turf/T = get_step(owner,owner.move_dir)
			if(!T.is_safe())
				owner.move_dir = 0x0
				frustration_move = frustration_move_threshold
				frustration_node_path = frustration_node_path_threshold
				frustration_astar_path = frustration_astar_path_threshold
				should_remove_frustration = FALSE

	if(!owner.anchored)
		owner.handle_movement(tick_rate)

	if(objective_attack && owner.z == objective_attack.z)
		owner.set_dir(get_dir(owner,objective_attack))
	else if(owner.move_dir)
		owner.set_dir(owner.move_dir)

	if(owner.move_dir && current_turf) //current_turf will only be assigned if they were supposed to move.
		if(master_ai)
			var/turf/T2 = get_turf(master_ai.owner)
			if(get_dist(T2,current_turf) > VIEW_RANGE) //Too far away.
				src.set_master_ai(null)
		else
			if(current_turf == get_turf(owner) && (!objective_attack || get_dist(owner,objective_attack) > 1)) //Did not move even though it was supposed to move.
				on_movement_fail()
				if(length(astar_path_current))
					if(frustration_astar_path_threshold > 0) frustration_astar_path++
				else if(length(node_path_current))
					if(frustration_node_path_threshold > 0) frustration_node_path++
				else
					if(frustration_move_threshold > 0) frustration_move++
				if(debug) log_debug("[src.get_debug_name()] tried moving, but couldn't.")
			else
				on_movement_pass()
				if(should_remove_frustration)
					if(length(astar_path_current))
						if(frustration_astar_path_threshold) frustration_astar_path_threshold = max(0,frustration_astar_path_threshold-1)
					else if(length(node_path_current))
						if(frustration_node_path_threshold) frustration_node_path_threshold = max(0,frustration_node_path_threshold-1)
					else
						if(frustration_move_threshold) frustration_move = max(0,frustration_move-1)

	return TRUE

/ai/proc/on_movement_pass()
	return TRUE

/ai/proc/on_movement_fail()
	return TRUE

/ai/proc/get_objective_delay() //In ticks.

	. = objective_delay

	if(use_alerts)
		switch(alert_level)
			if(ALERT_LEVEL_NOISE)
				. *= 0.75
			if(ALERT_LEVEL_CAUTION)
				. *= 0.5
			if(ALERT_LEVEL_COMBAT)
				. *= 0.25

	if(owner.next_move > 0) //We moved recently.
		. = 0

	if(objective_attack)
		. = max(.,SECONDS_TO_TICKS(4))
	else
		. = max(.,SECONDS_TO_TICKS(1))

/ai/proc/on_death()
	set_objective(null)
	set_path_node(null)
	set_path_astar(null)
	set_active(FALSE)
	return TRUE