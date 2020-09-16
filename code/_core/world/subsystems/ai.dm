SUBSYSTEM_DEF(ai)
	name = "AI Subsystem"
	desc = "Controls the AI of mobs."
	tick_rate = DECISECONDS_TO_TICKS(1) //Needs to be fast to handle mob movement.
	priority = SS_ORDER_PRELOAD
	cpu_usage_max = 80
	tick_usage_max = 80

	var/list/active_ai = list()
	var/list/inactive_ai = list()

	var/turf/list/stuck_turfs = list() //List of turfs that the AI keeps getting stuck on.

	use_time_dialation = FALSE

/subsystem/ai/on_life()

	for(var/k in active_ai)
		var/ai/AI = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		if(AI && !AI.owner)
			log_error("WARING! AI of type [AI.type] didn't have an owner!")
			qdel(AI)
			continue
		if(AI.should_life())
			AI.on_life(tick_rate)

	return TRUE