/mob/living/proc/can_block()

	if(!(attack_flags & CONTROL_MOD_BLOCK))
		return FALSE

	if(!can_move())
		return FALSE

	if(!isturf(loc))
		return FALSE

	if(has_trait(/trait/block_runner))
		if(move_delay < 0)
			return FALSE
	else
		if(move_mod >= 3)
			return FALSE

	if(has_status_effects(STAMCRIT,PARALYZE,SLEEP,PARRIED,FATIGUE,STUN))
		return FALSE

	return TRUE

/mob/living/proc/handle_blocking()

	if(blocking)
		if(!can_block())
			//Disabled
			animate(shield_overlay,alpha = 0, time = 3, flags = ANIMATION_LINEAR_TRANSFORM)
			blocking = FALSE
	else
		if(can_block())
			//Enabled
			animate(shield_overlay,alpha = 200, time = 5, easing = BACK_EASING | EASE_OUT, flags = ANIMATION_LINEAR_TRANSFORM)
			blocking = TRUE

