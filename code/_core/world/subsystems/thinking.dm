
/subsystem/thinking/
	name = "Think Subsystem"
	desc = "Any and all objects that think when it is active are handled here."
	priority = SS_ORDER_PRELOAD
	tick_rate = DECISECONDS_TO_TICKS(1)
	var/list/all_thinkers = list() //associative list

/subsystem/thinking/on_life()
	for(var/atom/A in all_thinkers)
		if(!A.think())
			stop_thinking(A)

	return TRUE

/proc/start_thinking(var/atom/A)
	A.thinks = TRUE
	SSthinking.all_thinkers[A] = TRUE

	return TRUE

/proc/stop_thinking(var/atom/A)
	A.thinks = FALSE
	if(SSthinking.all_thinkers[A])
		SSthinking.all_thinkers -= A

	return TRUE

