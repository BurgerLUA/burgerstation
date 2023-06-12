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
		set_alert_level(ALERT_LEVEL_COMBAT,A)
		return FALSE

	if(is_player(old_attack) && ai_attacking_players[old_attack])
		ai_attacking_players[old_attack] -= owner

	attackers -= old_attack

	if(A) owner.set_dir(get_dir(owner,A))

	if(is_living(A))
		if(!should_attack_mob(A,FALSE))
			return FALSE
		frustration_attack = 0
		set_active(TRUE)
		set_alert_level(ALERT_LEVEL_COMBAT,A)
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
		frustration_attack = 0
		set_active(TRUE)
		set_alert_level(ALERT_LEVEL_COMBAT,A)
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

	return TRUE

/ai/proc/handle_current_objectives(var/tick_rate)

	if(objective_attack.qdeleting || !objective_attack.health) //Object destroyed.
		set_objective(null)
		return FALSE

	if(get_dist(owner,objective_attack) > attack_distance_max) //Too far away.
		frustration_attack += tick_rate

	if(is_living(objective_attack))
		var/mob/living/L = objective_attack
		last_combat_location = get_turf(objective_attack)
		if(!should_attack_mob(L,FALSE))
			set_objective(null)
			return TRUE
		var/detection_level = get_detection_level(objective_attack,view_check=TRUE)
		if(detection_level <= 0) //Gone like the wind.
			set_objective(null)
			return TRUE
		else if(detection_level <= 0.25) //Basically out of combat, but not yet
			frustration_attack += tick_rate
		return TRUE

	//Non-living stuff here.

	if(!objective_attack.density) //Object is no longer dense.
		set_objective(null)
		return FALSE

	if(is_turf(objective_attack))
		var/turf/T = objective_attack
		if(!T.has_dense_atom || T.Enter(owner)) //No reason to attack the turf if it's fine now.
			set_objective(null)
			return FALSE
	else
		if(objective_attack.health.health_current <= 0) //Object destroyed.
			set_objective(null)
			return FALSE

	return TRUE

/ai/proc/find_new_objectives(var/tick_rate,var/bonus_sight=FALSE)

	if(CALLBACK_EXISTS("set_new_objective_\ref[src]"))
		return FALSE

	//Find a new living mob target.
	var/list/possible_targets = get_possible_targets(bonus_sight)
	var/atom/best_target
	var/best_score = -INFINITY
	var/best_detection_value = 0
	for(var/k in possible_targets)
		var/atom/A = k
		var/score_value = get_attack_score(A)
		var/detection_value = possible_targets[k]
		if(detection_value < 0.25)
			//Can't see.
			continue
		if(score_value <= best_score)
			//We have our sights focused on someone better.
			continue
		best_target = A
		best_score = score_value
		best_detection_value = detection_value

	if(best_target) //We found a new target!
		if(best_target == objective_attack) //Our best target is currently the one we're still attacking.
			set_alert_level(ALERT_LEVEL_COMBAT,best_target)
			return TRUE

		if(best_detection_value < 0.5) //Our best target is someone new outside combat detection range.
			try_investigate(best_target)
			return TRUE

		if(reaction_time > 0) //Delayed set_objective
			if(debug && ismob(best_target))
				var/mob/M = best_target
				if(M.client)
					M.to_chat(span("debug","Setting delayed objective target ([reaction_time])."))
			CALLBACK("set_new_objective_\ref[src]",reaction_time,src,src::set_objective(),best_target)
			return

		set_objective(best_target) //Forced set objective.
		return TRUE

	//Can't find any living beings to shoot.

	//Path to last combat location, if it exists.
	if(last_combat_location)
		try_investigate(last_combat_location,force_if_on_cooldown=TRUE)
		last_combat_location = null
		return TRUE

	//Find an obstacle to shoot.
	if(attack_obstacles && length(obstacles))
		var/atom/closest_obstacle
		var/best_distance = INFINITY
		var/view_range = get_view_range()
		for(var/k in obstacles)
			var/atom/A = k
			if(!A || A.qdeleting)
				obstacles -= k
				continue
			if(is_turf(A))
				if(!A.density || A.Enter(owner,owner.loc))
					obstacles -= k
					continue
			if(ismovable(A))
				if(!A.density || A.Cross(owner,owner.loc))
					obstacles -= k
					continue
			var/distance_check = get_dist(owner,A)
			if(distance_check <= view_range && (!closest_obstacle || distance_check < best_distance))
				closest_obstacle = A
		if(closest_obstacle)
			set_objective(closest_obstacle)

	return TRUE

/ai/proc/get_view_range()

	if(hunt_target) //We're hunting, so we're pretty cautious.
		return radius_find_enemy_caution

	. = radius_find_enemy

	switch(alert_level)
		if(ALERT_LEVEL_NOISE)
			. = radius_find_enemy_noise
		if(ALERT_LEVEL_CAUTION)
			. = radius_find_enemy_caution
		if(ALERT_LEVEL_COMBAT)
			. = radius_find_enemy_combat

	if(owner.has_status_effect(REST)) //Used for sleeping zombies.
		. *= 0.5

/ai/proc/get_possible_targets(var/bonus_sight=FALSE)

	. = list()

	if(aggression <= 0)
		return .

	var/range_to_use = get_view_range()
	if(range_to_use <= 0)
		return .

	for(var/k in hearers(range_to_use,owner))
		var/mob/living/L = k
		if(!is_living(L))
			continue
		if(!should_attack_mob(L))
			continue
		var/detection_level = get_detection_level(L,view_check=FALSE,bonus_sight=bonus_sight)
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

	if(!cooldown) //Do it instantly.
		return investigate(desired_target)

	if(CALLBACK_EXISTS("investigate_\ref[src]"))
		if(!force_if_on_cooldown)
			return FALSE
		CALLBACK_REMOVE("investigate_\ref[src]")
		return investigate(desired_target)

	owner.set_dir(get_dir(owner,desired_target)) //Look at the source of noise.
	CALLBACK("investigate_\ref[src]",reaction_time,src,src::investigate(),desired_target)

	return TRUE

/ai/proc/investigate(var/atom/desired_target)

	if(!desired_target)
		return FALSE

	if(!owner)
		return FALSE

	if(desired_target == objective_attack)
		return FALSE

	var/turf/T = get_turf(desired_target)
	if(!T)
		return FALSE

	set_path_fallback(T)

	return TRUE

