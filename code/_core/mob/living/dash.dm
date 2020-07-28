#define DASH_DELAY 1 //In deciseconds.

/mob/living/proc/dash(var/atom/dash_target,var/instances_left = 0)
	if(health)
		if(health.stamina_current < 50)
			to_chat(span("warning","You're exhausted!"))
			return FALSE
		health.adjust_stamina(-50)
		queue_health_update = TRUE

	var/dash_direction = get_dir(src,dash_target)
	glide_size = step_size/DECISECONDS_TO_TICKS(DASH_DELAY)
	Move(get_step(src,dash_direction),dash_direction)
	instances_left--
	if(instances_left > 0 && get_turf(dash_target) != get_turf(src))
		CALLBACK("dash_\ref[src]",DASH_DELAY,src,.proc/dash,dash_target,instances_left)
	return TRUE