/ai/proc/set_hunt_target(var/atom/A)

	if(!owner || owner.qdeleting)
		return FALSE

	if(A && (A.qdeleting || A == owner || owner.dead))
		return FALSE

	if(hunt_target == A)
		return FALSE

	if(ismob(hunt_target))
		var/mob/M = hunt_target
		if(M?.ckey && ckeys_being_hunt_by[M.ckey_last])
			ckeys_being_hunt_by[M.ckey_last] -= src

	hunt_target = A

	if(hunt_target)
		if(ismob(hunt_target))
			var/mob/M = hunt_target
			if(M.ckey_last)
				if(!ckeys_being_hunt_by[M.ckey_last])
					ckeys_being_hunt_by[M.ckey_last] = list()
				ckeys_being_hunt_by[M.ckey_last] += src
		set_active(TRUE)

	return TRUE

/ai/proc/set_objective(var/atom/A)

	if(!owner || owner.qdeleting)
		return FALSE

	if(A == owner)
		return FALSE

	if(A && A.qdeleting)
		return FALSE

	if(owner.dead && A != null)
		return FALSE

	var/atom/old_attack = objective_attack

	if(old_attack && old_attack == A)
		set_alert_level(ALERT_LEVEL_COMBAT,A,A)
		return FALSE

	if(is_player(old_attack) && ai_attacking_players[old_attack])
		ai_attacking_players[old_attack] -= owner

	attackers -= old_attack

	if(A) owner.set_dir(get_dir(owner,A))

	if(is_living(A))
		if(!should_attack_mob(A,FALSE))
			return FALSE
		objective_investigate = null
		frustration_attack = 0
		set_active(TRUE)
		set_alert_level(ALERT_LEVEL_COMBAT,A,A)
		objective_attack = A
		if(owner.boss && is_player(A))
			owner.add_player_to_boss(A)
		if(objective_move == objective_attack)
			objective_move = null
		owner.selected_intent = INTENT_HARM
		owner.update_intent()
		if(is_player(A))
			ai_attacking_players[A][owner] = TRUE
		for(var/k in linked_ais)
			var/ai/LAI = k
			LAI.set_objective(A)
		return TRUE
	else if(istype(A))
		objective_investigate = null
		frustration_attack = 0
		set_active(TRUE)
		set_alert_level(ALERT_LEVEL_COMBAT,A,A)
		objective_attack = A
		owner.selected_intent = INTENT_HARM
		owner.update_intent()
		for(var/k in linked_ais)
			var/ai/LAI = k
			LAI.set_objective(A)
		return TRUE

	frustration_attack = 0
	objective_attack = null
	owner.selected_intent = owner.stand ? INTENT_HARM : INTENT_HELP
	owner.update_intent()
	for(var/k in linked_ais)
		var/ai/LAI = k
		LAI.set_objective(null)


	if(!owner.dead && old_attack && !old_attack.qdeleting && is_living(old_attack))
		var/mob/living/L2 = old_attack
		if(L2.dead)
			try_investigate(L2)
			return TRUE

	return TRUE

/ai/proc/handle_current_objectives(var/tick_rate)

	if(objective_attack.qdeleting || !objective_attack.health)
		set_objective(null)
		return TRUE

	if(get_dist(owner,objective_attack) > attack_distance_max) //Too far away.
		frustration_attack += tick_rate
	else
		frustration_attack = 0

	if(is_living(objective_attack))
		if(!should_attack_mob(objective_attack,FALSE))
			set_objective(null)
			return TRUE
		last_combat_location = get_turf(objective_attack)
		var/detection_level = get_detection_level(objective_attack,view_check=TRUE)
		if(detection_level <= 0) //Gone completely.
			set_objective(null)
		else if(detection_level <= 0.25) //Basically out of combat, but not yet
			frustration_attack += tick_rate
		else
			frustration_attack = 0
		return TRUE

	if(!objective_attack.density) //Object is no longer dense.
		set_objective(null)
		return TRUE

	if(is_turf(objective_attack))
		if(objective_attack.Enter(owner)) //No reason to attack the turf.
			set_objective(null)
			return TRUE
	else
		if(objective_attack.health.health_current <= 0)
			set_objective(null)
			return TRUE

/ai/proc/find_new_objectives(var/tick_rate)

	//Find a new living mob target.
	var/list/possible_targets = get_possible_targets()
	var/atom/best_target
	var/best_score = -INFINITY
	var/best_detection_value = 0
	for(var/k in possible_targets)
		var/atom/A = k
		var/detection_value = possible_targets[k]
		var/score_value = get_attack_score(A)
		if((best_detection_value < night_vision && detection_value > best_detection_value) || (score_value > best_score && detection_value > night_vision))
			best_target = A
			best_score = score_value
			best_detection_value = detection_value

	if(best_target)
		if(best_target == objective_attack)
			set_alert_level(ALERT_LEVEL_COMBAT,best_target,best_target)
			return TRUE
		if(best_detection_value < night_vision*2)
			try_investigate(best_target)
			return TRUE
		else
			if(reaction_time > 0)
				if(debug && ismob(best_target))
					var/mob/M = best_target
					if(M.client)
						M.to_chat(span("debug","Setting delayed objective target ([reaction_time])."))
				CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,best_target)
			else
				set_objective(best_target)
		return TRUE

	//Path to last known location.
	if(last_combat_location && !length(astar_path_current))
		set_path_astar(last_combat_location)
		last_combat_location = null
		return TRUE

	//Find an obstacle to shoot.
	if(shoot_obstacles && length(obstacles))
		var/atom/closest_obstacle
		var/best_distance = INFINITY
		var/view_range = get_view_range()
		for(var/k in obstacles)
			var/atom/A = k
			if(A.qdeleting)
				obstacles -= k
				continue
			if(is_turf(A))
				if(A.Enter(owner,owner.loc))
					obstacles -= k
					continue
			if(ismovable(A))
				if(A.Cross(owner,owner.loc))
					obstacles -= k
					continue
			var/distance_check = get_dist(owner,A)
			if(distance_check <= view_range && (!closest_obstacle || distance_check < best_distance))
				closest_obstacle = A
		if(closest_obstacle)
			if(reaction_time)
				CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,closest_obstacle)
			else
				set_objective(closest_obstacle)

	//Find a new target if affected by a light.
	if(!objective_attack)
		var/turf/T = get_turf(owner)
		for(var/k in T.affecting_lights)
			var/light_source/LS = k
			if(!is_player(LS.top_atom))
				continue
			var/mob/living/L = LS.top_atom
			if(should_attack_mob(L))
				try_investigate(L,force_if_on_cooldown=TRUE)
				set_alert_level(ALERT_LEVEL_CAUTION,L,L)
				break

	return TRUE

/ai/proc/get_view_range()
	if(hunt_target)
		return radius_find_enemy_caution
	. = radius_find_enemy
	switch(alert_level)
		if(ALERT_LEVEL_NOISE)
			. = radius_find_enemy_noise
		if(ALERT_LEVEL_CAUTION)
			. = radius_find_enemy_caution
		if(ALERT_LEVEL_COMBAT)
			. = radius_find_enemy_combat
	if(owner.has_status_effect(REST)) //Mostly used for sleeping zombies.
		. *= 0.5

/ai/proc/get_possible_targets()

	. = list()

	if(aggression <= 0)
		return .

	var/range_to_use = get_view_range()
	if(range_to_use <= 0)
		return .

	for(var/mob/living/L in view(range_to_use,owner))
		if(!should_attack_mob(L))
			continue
		var/detection_level = get_detection_level(L)
		if(detection_level <= 0)
			continue
		.[L] = detection_level

/ai/proc/try_investigate(var/atom/desired_target,var/cooldown=reaction_time,var/force_if_on_cooldown=FALSE)

	if(!desired_target)
		return FALSE

	if(!owner)
		return FALSE

	if(desired_target == objective_attack)
		return FALSE

	if(!cooldown)
		. = investigate(desired_target)
	else
		if(CALLBACK_EXISTS("investigate_\ref[src]"))
			if(force_if_on_cooldown)
				. = investigate(desired_target)
			else
				return FALSE
		CALLBACK("investigate_\ref[src]",reaction_time,src,.proc/investigate,desired_target)
		. = TRUE

	if(.)
		if(alert_level < ALERT_LEVEL_CAUTION)
			set_alert_level(alert_level+1,desired_target,desired_target)



/ai/proc/investigate(var/atom/desired_target)

	if(!desired_target)
		return FALSE

	if(!owner)
		return FALSE

	if(desired_target == objective_attack)
		return FALSE

	objective_investigate = desired_target

	return TRUE

