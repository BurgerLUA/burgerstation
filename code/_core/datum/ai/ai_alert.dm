/ai/proc/set_alert_level(var/desired_alert_level,var/atom/alert_source = null,var/atom/alert_epicenter = null,var/can_lower=FALSE)

	if(!use_alerts)
		return FALSE

	if(!owner)
		return FALSE

	if(owner.dead && desired_alert_level != ALERT_LEVEL_NONE)
		return FALSE

	if(alert_source && alert_source == owner)
		return FALSE

	if(alert_level <= desired_alert_level && is_living(alert_source))
		var/mob/living/L = alert_source

		//Ignore alert changes (upwards) if it's by a non-player and we're not even active.
		if(!active && !is_player(L))
			return FALSE

		//Ignore sounds and stuff made by teammates, as well as people we generally do not give a fuck about if the sound is small.
		if(desired_alert_level <= ALERT_LEVEL_NOISE)
			if(radius_find_enemy <= 0 || !is_enemy(L,FALSE))
				return FALSE

		//Force the new epicenter to be the shitter that's causing it, as long as we're in a caution stage and the alert noise is high.
		if(!alert_epicenter || (alert_level >= ALERT_LEVEL_CAUTION && desired_alert_level >= ALERT_LEVEL_CAUTION))
			var/turf/T = get_turf(alert_source)
			if(T)
				alert_epicenter = T
	else if(!alert_epicenter)
		var/turf/T = get_turf(alert_source)
		if(T)
			alert_epicenter = T

	var/old_alert_level = alert_level

	if(can_lower)
		alert_level = desired_alert_level
	else
		alert_level = max(desired_alert_level,alert_level)

	if(old_alert_level <= alert_level && alert_level != ALERT_LEVEL_NONE)
		set_active(TRUE)
		if(owner.has_status_effect(REST))
			owner.remove_status_effect(REST)

	if(!objective_attack && should_investigate_alert && alert_epicenter && alert_level > old_alert_level)
		try_investigate(alert_epicenter,force_if_on_cooldown=TRUE)

	if(alert_level <= ALERT_LEVEL_NONE)
		CALLBACK_REMOVE("investigate_\ref[src]")

	if(old_alert_level != alert_level)
		on_alert_level_changed(old_alert_level,alert_level,alert_source)
		return TRUE

	return FALSE

/ai/proc/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	alert_time = initial(alert_time)

	if(use_alert_overlays)
		if(owner.alert_overlay && !owner.horizontal && !owner.is_sneaking)
			if(new_alert_level == ALERT_LEVEL_COMBAT)
				owner.alert_overlay.icon_state = "exclaim"
			else if(new_alert_level == ALERT_LEVEL_CAUTION)
				owner.alert_overlay.icon_state = "question"
			else if(new_alert_level == ALERT_LEVEL_NOISE)
				owner.alert_overlay.icon_state = "huh"
			else
				owner.alert_overlay.icon_state = "none"

	if(owner.combat_dialogue && next_talk <= world.time && prob(25))

		var/response_type
		var/swear_chance = 0
		if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_CAUTION)
			//Lost the enemy, going to investigate.
			response_type = "enemy_lost"
			swear_chance = 25
		else if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_NONE)
			//Threat neutralized.
			response_type = "enemy_down"
			swear_chance = 0
		else if(old_alert_level == ALERT_LEVEL_NONE && (new_alert_level == ALERT_LEVEL_NOISE || new_alert_level == ALERT_LEVEL_CAUTION))
			//A weird noise was made.
			response_type = "noise"
			swear_chance = owner.health ? (1 - owner.health.health_current/owner.health.health_max)*150 : 0
		else if(new_alert_level == ALERT_LEVEL_COMBAT)
			//Found the enemy again.
			response_type = "enemy_spotted"
			swear_chance = 90
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			//losing interest in the search
			response_type = "losing_interest"
			swear_chance = 10
		else if(new_alert_level == ALERT_LEVEL_NONE)
			//Investigated and determined there is nothing around.
			response_type = "lost_interest"
			swear_chance = 25
		if(response_type)
			do_dialogue(response_type,swear_chance)


	return TRUE