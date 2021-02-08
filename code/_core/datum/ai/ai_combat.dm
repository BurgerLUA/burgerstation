/ai/proc/attack_message()
	return TRUE

/ai/proc/can_owner_attack(var/atom/target,var/left_click=FALSE)
	return target.can_be_attacked(owner)

/ai/proc/do_attack(var/atom/target,var/left_click=FALSE)

	if(!owner || !target)
		return FALSE

	owner.move_dir = 0

	var/list/params = list(
		PARAM_ICON_X = num2text(pick(target_distribution_x)),
		PARAM_ICON_Y = num2text(pick(target_distribution_y)),
		"left" = 0,
		"right" = 0,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	if(left_click)
		params["left"] = TRUE
		owner.on_left_down(target,null,null,params)
	else
		params["right"] = TRUE
		owner.on_right_down(target,null,null,params)

	return TRUE

/ai/proc/handle_attacking()
	if(objective_attack && get_dist(owner,objective_attack) <= distance_target_max && objective_attack.can_be_attacked())
		var/is_left_click = prob(left_click_chance)
		spawn do_attack(objective_attack,is_left_click)
		return TRUE
	return FALSE


/ai/proc/get_attack_score(var/atom/A)

	var/dist = get_dist(A.loc,owner.loc)

	if(dist <= attack_distance_max)
		if(attackers[A])
			return 3000 - (A.health ? A.health.health_current : 0)
		if(is_living(A))
			var/mob/living/L = A
			if(L.ai && L.ai.objective_attack == owner)
				return 2000 - (A.health ? A.health.health_current : 0)
		return 1000 - (A.health ? A.health.health_current : 0)

	return -dist

/ai/proc/should_attack_mob(var/mob/living/L,var/aggression_check=TRUE)

	if(L.z != owner.z)
		return FALSE

	if(L == owner)
		return FALSE

	if(L.qdeleting)
		return FALSE

	if(L.dead)
		return FALSE

	if(L.immortal && !ignore_immortal)
		return FALSE

	if(timeout_threshold && L.client && L.client.inactivity >= DECISECONDS_TO_TICKS(timeout_threshold))
		return FALSE

	if(!is_enemy(L,FALSE,aggression_check))
		return FALSE

	if(!L.can_be_attacked(owner))
		return FALSE

	if(is_advanced(L) && !L.client)
		var/mob/living/advanced/A = L
		if(A.handcuffed) //Don't target hostages.
			return FALSE

	return TRUE

/ai/proc/is_enemy(var/atom/A,var/safety_check=TRUE,var/aggression_check=TRUE)

	/*
	if(istype(A,/mob/living/vehicle/))
		var/mob/living/vehicle/V = A
		if(!length(V.passengers))
			return FALSE
		A = V.passengers[1]
	*/

	if(A == owner)
		return FALSE

	if(is_living(A))
		var/mob/living/L = A
		if(L.ai)
			if(L.ai.objective_attack)
				if(L.ai.objective_attack == owner)
					return TRUE
				if(assistance == 1 && is_living(L.ai.objective_attack))
					var/mob/living/L2 = L.ai.objective_attack
					if(L2.loyalty_tag == owner.loyalty_tag)
						return TRUE
			if(predict_attack && !safety_check && L.ai.is_enemy(owner,TRUE))
				return TRUE

	if(!aggression_check)
		return TRUE

	switch(aggression)
		if(0)
			return FALSE
		if(1)
			if(!is_living(A))
				return FALSE
			var/mob/living/L = A
			return owner.loyalty_tag && L.loyalty_tag && (L.loyalty_tag in enemy_tags)
		if(2)
			if(!is_living(A))
				return TRUE
			var/mob/living/L = A
			return owner.loyalty_tag != L.loyalty_tag
		if(3)
			return TRUE

	return FALSE

/ai/proc/is_friend(var/mob/living/L)
	return owner.loyalty_tag && L.loyalty_tag == owner.loyalty_tag

/ai/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(is_living(attacker) && !stealthy && attacker != objective_attack)
		if(should_attack_mob(attacker,FALSE))
			if(!attackers[attacker])
				attackers[attacker] = TRUE
			if(!objective_attack && !CALLBACK_EXISTS("set_new_objective_\ref[src]"))
				if(reaction_time)
					CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,attacker)
				else
					set_objective(attacker)
		else if(alert_level != ALERT_LEVEL_COMBAT)
			set_alert_level(ALERT_LEVEL_CAUTION,FALSE,attacker,attacker)
			CALLBACK("investigate_\ref[src]",CEILING(reaction_time*0.5,1),src,.proc/investigate,attacker)

	return TRUE