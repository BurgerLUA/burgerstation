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

	if(old_attack == A)
		return FALSE

	if(is_player(old_attack))
		ai_attacking_players[old_attack] -= owner

	attackers -= old_attack

	if(A) owner.set_dir(get_dir(owner,A))

	if(objective_investigate)
		objective_investigate = null

	if(is_living(A))
		if(!should_attack_mob(A,FALSE))
			return FALSE
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
		return TRUE
	else if(istype(A))
		frustration_attack = 0
		set_active(TRUE)
		set_alert_level(ALERT_LEVEL_COMBAT,A,A)
		objective_attack = A
		owner.selected_intent = INTENT_HARM
		owner.update_intent()
		return TRUE

	frustration_attack = 0
	objective_attack = null
	owner.selected_intent = owner.stand ? INTENT_HARM : INTENT_HELP
	owner.update_intent()

	if(!owner.dead && old_attack && !old_attack.qdeleting)
		if(is_living(old_attack))
			var/mob/living/L2 = old_attack
			if(L2.dead)
				set_alert_level(ALERT_LEVEL_NOISE,TRUE)
				return TRUE
		set_alert_level(ALERT_LEVEL_CAUTION,TRUE)
		set_move_objective(old_attack)
		return TRUE

	set_alert_level(ALERT_LEVEL_NONE,TRUE)

	return TRUE

/ai/proc/handle_light()

	var/turf/T = get_turf(owner)

	for(var/k in T.affecting_lights)
		var/light_source/LS = k
		if(!is_player(LS.top_atom))
			continue
		var/mob/living/L = LS.top_atom
		if(should_attack_mob(L))
			set_alert_level(ALERT_LEVEL_CAUTION,L,L)
			break

	return TRUE

/ai/proc/handle_objectives(var/tick_rate)

	if(CALLBACK_EXISTS("set_new_objective_\ref[src]"))
		return TRUE

	if(objective_attack)
		if(objective_attack.qdeleting || !objective_attack.health || (!is_living(objective_attack) && objective_attack.health.health_current <= 0) )
			set_objective(null)
		else if(is_living(objective_attack))
			if(!should_attack_mob(objective_attack,FALSE))
				set_objective(null)
			else
				last_combat_location = get_turf(objective_attack)
				var/detection_level = get_detection_level(objective_attack,view_check=TRUE)
				if(detection_level <= 0) //Gone completely.
					set_objective(null)
				else if(detection_level <= 0.25) //Basically out of combat, but not yet
					frustration_attack += tick_rate
				else
					frustration_attack = 0

		else if(isturf(objective_attack) && objective_attack.Enter(owner))
			set_objective(null)
		else if(get_dist(owner,objective_attack) > attack_distance_max)
			frustration_attack += tick_rate
		else
			frustration_attack = 0
	else
		handle_light()

	if(!objective_attack || frustration_attack > frustration_attack_threshold)
		var/list/possible_targets = get_possible_targets()
		var/atom/best_target
		var/best_score = 0
		var/best_detection_value = 0
		for(var/k in possible_targets)
			var/atom/A = k
			var/detection_value = possible_targets[k]
			var/score_value = get_attack_score(A)
			if(!best_score || (score_value > best_score && detection_value >= best_detection_value))
				best_target = A
				best_score = score_value
				best_detection_value = detection_value
		if(best_target && best_target != objective_attack && best_detection_value > 0.25)
			if(best_detection_value < 0.5)
				investigate(best_target)
			else
				if(reaction_time > 0)
					if(debug && ismob(best_target))
						var/mob/M = best_target
						if(M.client)
							M.to_chat(span("debug","Setting delayed objective target ([reaction_time])."))
					CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,best_target)
				else
					set_objective(best_target)
		else if(last_combat_location && !length(current_path_astar))
			set_path_astar(last_combat_location)
		frustration_attack = 0

	if(!objective_attack && shoot_obstacles && length(obstacles) && !CALLBACK_EXISTS("set_new_objective_\ref[src]"))
		var/atom/closest_obstacle
		var/best_distance = INFINITY
		var/view_range = get_view_range()
		for(var/k in obstacles)
			var/atom/A = k
			if(A.qdeleting)
				obstacles -= k
				continue
			if(isturf(A))
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

	return TRUE

/ai/proc/get_view_range()
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
		.[L] = get_detection_level(L)

/ai/proc/investigate(var/atom/desired_target)

	if(!desired_target)
		return FALSE

	if(!owner)
		return FALSE

	if(desired_target == objective_attack)
		return FALSE

	owner.set_dir(get_dir(owner,desired_target))
	objective_investigate = desired_target

	return TRUE

/ai/proc/set_alert_level(var/desired_alert_level,var/can_lower=FALSE,var/atom/alert_epicenter = null,var/atom/alert_source = null)

	if(!use_alerts)
		return FALSE

	if(!owner)
		return FALSE

	if(owner.dead && desired_alert_level != ALERT_LEVEL_NONE)
		return FALSE

	if(alert_level <= alert_level && is_living(alert_source))
		var/mob/living/L = alert_source
		if(alert_level == ALERT_LEVEL_CAUTION)
			if(L == owner)
				return FALSE
		else
			if(!is_enemy(L,FALSE) || radius_find_enemy <= 0 )
				return FALSE //Ignore sounds and stuff made by teammates, as well as people we do not give a fuck about.

	var/old_alert_level = alert_level

	if(can_lower)
		alert_level = desired_alert_level
	else
		alert_level = max(desired_alert_level,alert_level)

	if(old_alert_level <= alert_level && alert_level != ALERT_LEVEL_NONE)
		set_active(TRUE)
		if(owner.has_status_effect(REST))
			owner.remove_status_effect(REST)

	if(should_investigate_alert && alert_epicenter && (alert_level == ALERT_LEVEL_NOISE || alert_level == ALERT_LEVEL_CAUTION) && !CALLBACK_EXISTS("investigate_\ref[src]") && (old_alert_level >= alert_level ? TRUE : prob(50)) )
		CALLBACK("investigate_\ref[src]",CEILING(reaction_time*0.5,1),src,.proc/investigate,alert_epicenter)

	if(old_alert_level != alert_level)
		on_alert_level_changed(old_alert_level,alert_level,alert_source)
		return TRUE

	return FALSE

/ai/proc/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	alert_time = initial(alert_time)

	if(debug)
		if(owner.alert_overlay && !owner.horizontal && !owner.is_sneaking)
			if(new_alert_level == ALERT_LEVEL_COMBAT)
				owner.alert_overlay.icon_state = "exclaim"
			else if(new_alert_level == ALERT_LEVEL_CAUTION)
				owner.alert_overlay.icon_state = "question"
			else if(new_alert_level == ALERT_LEVEL_NOISE)
				owner.alert_overlay.icon_state = "huh"
			else
				owner.alert_overlay.icon_state = "none"

	if(combat_dialogue && next_talk <= world.time && prob(25))

		var/response_type
		var/swear_chance = 0
		if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_CAUTION)
			//Lost the enemy, going to investigate.
			response_type = "lost_enemy"
			swear_chance = 25
		else if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_NONE)
			//Threat neutralized.
			response_type = "enemy_down"
			swear_chance = 0
		else if(old_alert_level == ALERT_LEVEL_CAUTION && new_alert_level == ALERT_LEVEL_COMBAT)
			//Found the enemy again.
			response_type = "enemy_found"
			swear_chance = 90
		else if(old_alert_level == ALERT_LEVEL_NONE && (new_alert_level == ALERT_LEVEL_NOISE || new_alert_level == ALERT_LEVEL_CAUTION))
			//A weird noise was made.
			response_type = "noise"
			swear_chance = owner.health ? (1 - owner.health.health_current/owner.health.health_max)*150 : 0
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			//losing interest in the search
			response_type = "losing_interest"
			swear_chance = 10
		else if(new_alert_level == ALERT_LEVEL_NONE)
			//Investigated and determined there is nothing around.
			response_type = "lost_interest"
			swear_chance = 25
		if(response_type)
			var/returning_dialogue = SSdialogue.get_combat_dialogue(combat_dialogue,response_type,swear_chance)
			if(returning_dialogue) owner.do_say(returning_dialogue,language_to_use = language_to_use)
			next_talk = world.time + SECONDS_TO_DECISECONDS(5)


	return TRUE