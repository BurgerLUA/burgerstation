SUBSYSTEM_DEF(thinking)
	name = "Think Subsystem"
	desc = "Any and all objects that think when it is active are handled here."
	priority = SS_ORDER_THINK
	tick_rate = DECISECONDS_TO_TICKS(1)
	var/list/all_thinkers = list() //associative list

	tick_usage_max = 99

/subsystem/thinking/unclog(var/mob/caller)

	for(var/k in src.all_thinkers)
		all_thinkers -= k

	. = ..()

/subsystem/thinking/on_life()

	for(var/k in all_thinkers)
		var/atom/A = k
		if(!A || A.qdeleting)
			all_thinkers -= A
			continue
		if(!A.think())
			STOP_THINKING(A)
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE