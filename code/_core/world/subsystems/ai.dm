SUBSYSTEM_DEF(ai)
	name = "AI Subsystem"
	desc = "Controls the AI of mobs."
	tick_rate = DECISECONDS_TO_TICKS(AI_TICK)
	priority = SS_ORDER_PRELOAD

	var/list/active_ai = list()
	var/list/inactive_ai = list()

/subsystem/ai/on_life()

	for(var/ai/AI in active_ai)
		CHECK_TICK
		if(AI && !AI.owner)
			log_error("WARING! AI of type [AI.type] didn't have an owner!")
			qdel(AI)
			continue
		if(AI.should_life())
			AI.on_life()

	return TRUE