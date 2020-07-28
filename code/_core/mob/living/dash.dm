#define DASH_DELAY 1 //In deciseconds.

/mob/living/proc/dash(var/atom/dash_target,var/dash_direction=0x0,var/instances_left = 0)//Can either input dash target or dash direction.
	if(health)
		if(health.stamina_current < 25)
			to_chat(span("warning","You're exhausted!"))
			return FALSE
		health.adjust_stamina(-25)
		queue_health_update = TRUE

	var/final_direction = dash_direction ? dash_direction : get_dir(src,dash_target)
	glide_size = step_size/DECISECONDS_TO_TICKS(DASH_DELAY)
	Move(get_step(src,final_direction),final_direction)
	instances_left--
	if(instances_left > 0 && (dash_direction || (get_turf(dash_target) != get_turf(src))))
		CALLBACK("dash_\ref[src]",DASH_DELAY,src,.proc/dash,dash_target,dash_direction,instances_left)
	return TRUE