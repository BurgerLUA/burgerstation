SUBSYSTEM_DEF(bossai)
	name = "Boss AI Subsystem"
	desc = "Controls the AI of bosses."
	tick_rate = DECISECONDS_TO_TICKS(BOSS_TICK)
	priority = SS_ORDER_IMPORTANT
	cpu_usage_max = 100
	tick_usage_max = 100

	var/list/active_ai = list()
	var/list/inactive_ai = list()

/subsystem/bossai/on_life()

	for(var/k in active_ai)
		var/ai/AI = k
		CHECK_TICK(tick_usage_max,FPS_SERVER*0.25)
		if(AI && !AI.owner)
			log_error("WARING! AI of type [AI.type] didn't have an owner!")
			qdel(AI)
			continue
		if(AI.should_life())
			AI.on_life(tick_rate)

	return TRUE