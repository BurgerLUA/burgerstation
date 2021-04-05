/ai/proc/should_life()

	if(!active)
		return FALSE

	if(!owner)
		qdel(src)
		return FALSE

	if(!owner.initialized)
		return FALSE

	if(owner.dead)
		return FALSE

	if(!isturf(owner.loc))
		return FALSE

	if(owner.has_status_effects(STUN,SLEEP,PARALYZE))
		return FALSE

	if(resist_grabs && owner.grabbing_hand && owner.next_resist <= world.time && is_enemy(owner.grabbing_hand.owner,FALSE))
		owner.resist()
		return FALSE

	return TRUE

/ai/proc/on_life(var/tick_rate)

	objective_ticks += tick_rate
	var/objective_delay = get_objective_delay()
	if(objective_ticks >= objective_delay)
		objective_ticks = 0
		handle_objectives(objective_delay)
		if(length(current_path) || objective_attack || alert_level >= ALERT_LEVEL_NOISE)
			idle_time = 0
		else
			idle_time += objective_delay
			if(idle_time >= 600) //Idle for more than a minute means you're just wasting space.
				set_active(FALSE)
				return FALSE

	if(owner.attack_next <= world.time)
		handle_attacking()

	if(alert_level >= ALERT_LEVEL_NOISE && alert_level <= ALERT_LEVEL_CAUTION)
		alert_time -= tick_rate
		if(alert_time <= 0)
			alert_time = initial(alert_time)
			set_alert_level(max(0,alert_level-1),TRUE)

	if(owner.move_delay <= 0)
		handle_movement()

	owner.handle_movement(tick_rate)

	return TRUE

/ai/proc/get_objective_delay()

	. = objective_delay

	if(objective_attack)
		. = max(.,SECONDS_TO_DECISECONDS(4))

/ai/proc/on_death()
	set_objective(null)
	set_path(null)
	set_active(FALSE)
	return TRUE