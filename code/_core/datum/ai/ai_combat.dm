/ai/proc/attack_message()
	return TRUE

/ai/proc/do_attack(var/atom/target,var/left_click=FALSE)

	if(!owner || !target)
		return FALSE

	owner.move_dir = 0

	var/list/params = list(
		PARAM_ICON_X = pick(target_distribution_x),
		PARAM_ICON_Y = pick(target_distribution_y),
		"left" = 0,
		"right" = 0,
		"middle" = 0,
		"ctrl" = 0,
		"shift" = 0,
		"alt" = 0
	)

	if(debug) log_debug("Do attack: [target].")

	if(left_click)
		params["left"] = TRUE
		owner.on_left_down(target,null,null,params)
	else
		params["right"] = TRUE
		owner.on_right_down(target,null,null,params)

	return TRUE

/ai/proc/handle_attacking()

	if(!objective_attack)
		return FALSE

	if(get_dist(owner,objective_attack) > distance_target_max)
		return FALSE

	var/atom/objective_to_attack = objective_attack
	if(!objective_to_attack.z) //Inside something.
		objective_to_attack = objective_to_attack.loc
		knows_about_lockers = TRUE
		if(debug) log_debug("Knows about lockers")

	if(!objective_to_attack) //Must be a null loc or something.
		if(debug) log_debug("Null loc!")
		return FALSE

	spawn do_attack(objective_to_attack,prob(left_click_chance)) //The spawn here is important as attacking has its own sleeps and whatnot.
	return TRUE


var/global/list/difficulty_to_ai_modifier = list(
	DIFFICULTY_EASY = 1,
	DIFFICULTY_NORMAL = 2,
	DIFFICULTY_HARD = 4,
	DIFFICULTY_EXTREME = 6,
	DIFFICULTY_SURVIVOR = 6
)

/ai/proc/get_attack_score(var/atom/A) //Higher the score, the better.

	var/dist = get_dist(A.loc,owner.loc)

	if(dist <= attack_distance_max)
		if(attackers[A])
			return -2 //Target those who attacked you, but still attack those who are literally touching you.
		if(is_living(A))
			var/mob/living/L = A
			if(L.ai)
				if(L.ai.objective_attack == owner)
					return 9999 //Prioritize AI wars.
				return -dist*0.25 //Prioritize attacking other AI.
			if(is_player(A))
				var/mob/living/advanced/player/P = L
				var/difficulty_mod = difficulty_to_ai_modifier[P.get_difficulty()]
				if(!difficulty_mod)
					difficulty_mod = 1
				if(attack_distance_max > 2 && length(ai_attacking_players[A]) > 1*difficulty_mod && !ai_attacking_players[A][owner])
					return -9999 //Wow they're being overwhelmed. Very lowest priority.
				var/health_mod = 0.5 + 1-(A.health ? max(0,A.health.health_current/A.health.health_max) : 0.5)
				return -dist*health_mod*(1/difficulty_mod) //Attack those with high health. Low health will be spared. Higher difficulty will make you more desirable.

	return -dist

/ai/proc/should_attack_mob(var/mob/living/L,var/aggression_check=TRUE)

	if(L == owner)
		return FALSE

	if(L.qdeleting)
		return FALSE

	if(L.dead)
		return FALSE

	if(!L.health && !ignore_immortal)
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

	if(istype(A,/mob/living/vehicle/))
		var/mob/living/vehicle/V = A
		if(!length(V.passengers))
			return FALSE
		A = V.passengers[1]

	if(A == owner)
		return FALSE

	if(!is_living(A))
		return FALSE

	var/mob/living/L = A
	if(L.ai)
		if(L.ai.objective_attack)
			if(L.ai.objective_attack == owner)
				return TRUE
			if(assistance == 1 && is_living(L.ai.objective_attack))
				var/mob/living/L2 = L.ai.objective_attack
				if(allow_helpful_action(L2.loyalty_tag,owner.loyalty_tag))
					return TRUE
		if(predict_attack && !safety_check && L.ai.is_enemy(owner,TRUE))
			return TRUE

	if(aggression_check)
		return check_aggression(L)

	return TRUE

/ai/proc/check_aggression(var/mob/living/target,var/aggression_override = src.aggression)

	switch(aggression_override)
		if(0)
			return FALSE
		if(1)
			var/area/A = get_area(owner)
			return owner.loyalty_tag && target.loyalty_tag && allow_hostile_action(owner.loyalty_tag,target.loyalty_tag,A) && (target.loyalty_tag in enemy_tags)
		if(2)
			var/area/A = get_area(owner)
			return allow_hostile_action(owner.loyalty_tag,target.loyalty_tag,A)
		if(3)
			return TRUE

	return FALSE

/ai/proc/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(is_living(attacker) && !stealthy && attacker != objective_attack)
		if(should_attack_mob(attacker,FALSE))
			if(!attackers[attacker])
				attackers[attacker] = TRUE
			if(!CALLBACK_EXISTS("set_new_objective_\ref[src]") && (!objective_attack || (get_dist(owner,objective_attack) >= get_dist(owner,attacker)*2)))
				if(reaction_time)
					CALLBACK("set_new_objective_\ref[src]",reaction_time,src,.proc/set_objective,attacker)
				else
					set_objective(attacker)
		else if(alert_level != ALERT_LEVEL_COMBAT)
			set_alert_level(ALERT_LEVEL_CAUTION,FALSE,attacker,attacker)
			CALLBACK("investigate_\ref[src]",CEILING(reaction_time*0.5,1),src,.proc/investigate,attacker)

	if(combat_dialogue && !stealthy && next_talk <= world.time && damage_amount >= 30 && prob(20+damage_amount))
		var/returning_dialogue = SSdialogue.get_combat_dialogue(combat_dialogue,"self_hit",damage_amount)
		if(returning_dialogue) owner.do_say(returning_dialogue,language_to_use = language_to_use)
		next_talk = world.time + SECONDS_TO_DECISECONDS(5)


	return TRUE