SUBSYSTEM_DEF(bossai)
	name = "Boss AI Subsystem"
	desc = "Controls the AI of bosses."
	tick_rate = DECISECONDS_TO_TICKS(AI_TICK)
	priority = SS_ORDER_IMPORTANT
	cpu_usage_max = 100
	tick_usage_max = 100

	var/list/active_ai = list()
	var/list/inactive_ai = list()

/subsystem/bossai/on_life()

	for(var/ai/AI in active_ai)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		if(AI && !AI.owner)
			log_error("WARING! AI of type [AI.type] didn't have an owner!")
			qdel(AI)
			continue
		if(AI.should_life())
			AI.on_life()

	return TRUE