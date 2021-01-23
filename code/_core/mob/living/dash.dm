#define DASH_DELAY 2 //In deciseconds.

/mob/living/proc/dash(var/atom/dash_target,var/dash_direction=0x0,var/instances_left = 0)//Can either input dash target or dash direction.

	if(!can_move())
		return FALSE

	if(!src.client)
		CRASH_SAFE("Dash called on non-player!")
		return FALSE

	if(health)
		if(health.stamina_current < 25)
			to_chat(span("warning","You can't dash, you're exhausted!"))
			return FALSE
		health.adjust_stamina(-25)
		queue_health_update = TRUE

	var/final_direction = dash_direction ? dash_direction : get_dir(src,dash_target)
	glide_size = step_size/DECISECONDS_TO_TICKS(DASH_DELAY)
	Move(get_step(src,final_direction))
	src.set_dir(final_direction)
	instances_left--
	if(instances_left > 0 && (dash_direction || (get_turf(dash_target) != get_turf(src))))
		CALLBACK("dash_\ref[src]",DASH_DELAY,src,.proc/dash,dash_target,dash_direction,instances_left)
	return TRUE


/mob/living/proc/can_block()

	if(!(attack_flags & CONTROL_MOD_BLOCK))
		return FALSE

	if(!can_move())
		return FALSE

	if(!isturf(loc))
		return FALSE

	if(move_mod >= 3)
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

