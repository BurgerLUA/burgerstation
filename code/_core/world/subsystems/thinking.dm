SUBSYSTEM_DEF(thinking)
	name = "Think Subsystem"
	desc = "Any and all objects that think when it is active are handled here."
	priority = SS_ORDER_PRELOAD
	tick_rate = DECISECONDS_TO_TICKS(1)
	var/list/all_thinkers = list() //associative list

	cpu_usage_max = 100
	tick_usage_max = 100

/subsystem/thinking/unclog(var/mob/caller)
	for(var/k in src.all_thinkers)
		all_thinkers -= k
	broadcast_to_clients(span("danger","Stopped all thinkers."))
	return ..()

/subsystem/thinking/on_life()
	for(var/k in all_thinkers)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		var/atom/A = k
		if(!A || A.qdeleting)
			all_thinkers -= A
			continue
		if(!A.think())
			stop_thinking(A)

	return TRUE

/proc/start_thinking(var/atom/A)
	SSthinking.all_thinkers[A] = TRUE
	return TRUE

/proc/stop_thinking(var/atom/A)
	if(SSthinking.all_thinkers[A])
		SSthinking.all_thinkers -= A

	return TRUE

/proc/is_thinking(var/atom/A)
	return SSthinking.all_thinkers[A]
