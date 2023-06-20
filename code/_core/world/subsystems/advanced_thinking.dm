SUBSYSTEM_DEF(advanced_thinking)
	name = "Advanced Think Subsystem"
	desc = "Any and all objects that think when it is active are handled here."
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(1)
	var/list/all_thinkers = list() //associative list

	tick_usage_max = 75

/subsystem/advanced_thinking/unclog(var/mob/caller)
	for(var/k in src.all_thinkers)
		all_thinkers -= k
	return ..()

/subsystem/advanced_thinking/on_life()
	for(var/k in all_thinkers)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		var/atom/A = k
		if(!A || A.qdeleting)
			all_thinkers -= A
			continue
		if(!A.think())
			stop_advanced_thinking(A)

	return TRUE

/proc/start_advanced_thinking(var/atom/A)
	SSadvanced_thinking.all_thinkers[A] = TRUE
	return TRUE

/proc/stop_advanced_thinking(var/atom/A)
	if(SSadvanced_thinking.all_thinkers[A])
		SSadvanced_thinking.all_thinkers -= A
	return TRUE

/proc/is_advanced_thinking(var/atom/A)
	return SSadvanced_thinking.all_thinkers[A]
