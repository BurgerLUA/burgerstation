/ai/proc/set_objective(var/atom/A)

	if(!owner || owner.qdeleting)
		return FALSE

	if(A == owner)
		return FALSE

	if(A && A.qdeleting)
		return FALSE

	var/atom/old_attack = objective_attack

	if(old_attack == A)
		return FALSE

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
		owner.set_intent(objective_attack || owner.stand ? INTENT_HARM : INTENT_HELP)
		return TRUE
	else if(istype(A))
		frustration_attack = 0
		set_active(TRUE)
		set_alert_level(ALERT_LEVEL_COMBAT,A,A)
		objective_attack = A
		owner.set_intent(objective_attack || owner.stand ? INTENT_HARM : INTENT_HELP)
		return TRUE

	frustration_attack = 0

	objective_attack = null
	owner.set_intent(owner.stand ? INTENT_HARM : INTENT_HELP)

	if(old_attack && !old_attack.qdeleting)
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

	for(var/light_source/LS in T.affecting_lights)
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
		if(objective_attack.qdeleting || !objective_attack.health)
			set_objective(null)
		else if(is_living(objective_attack))
			if(!should_attack_mob(objective_attack,FALSE))
				set_objective(null)
			else
				var/sight_chance = get_sight_chance(objective_attack)
				if(sight_chance <= 0)
					set_objective(null)
					frustration_attack = 0
				else if(sight_chance <= 50)
					frustration_attack += tick_rate
				else
					frustration_attack = 0
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
		for(var/k in possible_targets)
			var/atom/A = k
			var/local_score = get_attack_score(A)
			if(!best_score || local_score > best_score)
				best_target = A
				best_score = local_score
		if(best_target && best_target != objective_attack)
			if(reaction_time)
				CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,best_target)
			else
				set_objective(best_target)

		frustration_attack = 0

	if(!objective_attack && shoot_obstacles && length(obstacles) && !CALLBACK_EXISTS("set_new_objective_\ref[src]"))
		var/atom/closest_obstacle
		var/best_distance = INFINITY
		for(var/k in obstacles)
			var/atom/A = k
			if(A.qdeleting)
				obstacles -= k
				continue
			if(isturf(A))
				if(A.Enter(owner,get_turf(owner)))
					obstacles -= k
					continue
			if(ismovable(A))
				if(A.Cross(owner))
					obstacles -= k
					continue
			if(!closest_obstacle || get_dist(owner,A) < best_distance)
				closest_obstacle = A
		if(closest_obstacle)
			if(reaction_time)
				CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,closest_obstacle)
			else
				set_objective(closest_obstacle)

	return TRUE

/ai/proc/get_possible_targets()

	. = list()

	if(retaliate && length(attackers))
		for(var/k in attackers)
			var/atom/A = k
			if(A.qdeleting)
				attackers -= k
				continue
			.[A] = TRUE

	var/range_to_use = radius_find_enemy
	switch(alert_level)
		if(ALERT_LEVEL_NOISE)
			range_to_use = radius_find_enemy_noise
		if(ALERT_LEVEL_CAUTION)
			range_to_use = radius_find_enemy_caution
		if(ALERT_LEVEL_COMBAT)
			range_to_use = radius_find_enemy_combat

	if(range_to_use <= 0)
		return .

	if(aggression > 0)
		for(var/mob/living/L in view(range_to_use,owner))
			CHECK_TICK(75,FPS_SERVER*2)
			var/sight_chance = get_sight_chance(L,FALSE)
			if(sight_chance < 100 && !prob(sight_chance))
				continue
			CHECK_TICK(75,FPS_SERVER*2)
			if(!should_attack_mob(L))
				continue
			.[L] = TRUE

	return .


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

	if(!owner || owner.dead)
		return FALSE

	if(alert_level <= alert_level && alert_source && is_living(alert_source))
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

	owner.move_dir = 0

	if(old_alert_level != alert_level)
		set_active(TRUE)
		if(should_investigate_alert && alert_epicenter && (alert_level == ALERT_LEVEL_NOISE || alert_level == ALERT_LEVEL_CAUTION))
			if(!CALLBACK_EXISTS("investigate_\ref[src]")) CALLBACK("investigate_\ref[src]",CEILING(reaction_time*0.5,1),src,.proc/investigate,alert_epicenter)
		on_alert_level_changed(old_alert_level,alert_level,alert_source)
		return TRUE

	return FALSE

/ai/proc/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	if(owner.alert_overlay)
		if(new_alert_level == ALERT_LEVEL_COMBAT)
			owner.alert_overlay.icon_state = "exclaim"
		else if(new_alert_level == ALERT_LEVEL_CAUTION)
			owner.alert_overlay.icon_state = "question"
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			owner.alert_overlay.icon_state = "huh"
		else
			owner.alert_overlay.icon_state = "none"

	return TRUE