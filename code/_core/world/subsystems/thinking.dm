SUBSYSTEM_DEF(thinking)
	name = "Think Subsystem"
	desc = "Any and all objects that think when it is active are handled here."
	priority = SS_ORDER_PRELOAD
	tick_rate = DECISECONDS_TO_TICKS(1)
	var/list/all_thinkers = list() //associative list

	cpu_usage_max = 75
	tick_usage_max = 75

/subsystem/thinking/on_life()
	for(var/atom/A in all_thinkers)
		CHECK_TICK_ADV(tick_usage_max)
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

