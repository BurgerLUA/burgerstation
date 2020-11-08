SUBSYSTEM_DEF(bossai)
	name = "Boss AI Subsystem"
	desc = "Controls the AI of bosses."
	tick_rate = DECISECONDS_TO_TICKS(BOSS_TICK)
	priority = SS_ORDER_IMPORTANT
	cpu_usage_max = 100
	tick_usage_max = 100

	var/list/active_ai = list()
	var/list/inactive_ai = list()

/subsystem/bossai/unclog(var/mob/caller)

	for(var/k in active_ai)
		var/ai/AI = k
		if(AI.owner)
			qdel(AI.owner)
		else
			qdel(AI)
	broadcast_to_clients(span("danger","Deleted all boss mobs and AIs."))

	return ..()

/subsystem/bossai/on_life()

	for(var/k in active_ai)
		var/ai/AI = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		if(AI && !AI.owner)
			log_error("WARING! AI of type [AI.type] didn't have an owner!")
			qdel(AI)
			continue
		var/should_life = AI.should_life()
		if(should_life == null || (should_life && AI.on_life(tick_rate) == null))
			log_error("WARING! AI of type [AI.type] in [AI.owner.get_debug_name()] likely hit a runtime and was deleted, along with its owner.")
			qdel(AI.owner)

	return TRUE