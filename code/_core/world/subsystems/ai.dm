SUBSYSTEM_DEF(ai)
	name = "AI Subsystem"
	desc = "Controls the AI of mobs."
	tick_rate = DECISECONDS_TO_TICKS(AI_TICK) //Needs to be fast to handle mob movement.
	priority = SS_ORDER_PRELOAD
	cpu_usage_max = 80
	tick_usage_max = 80

	var/list/active_ai = list()
	var/list/inactive_ai = list()

	use_time_dialation = FALSE

/subsystem/ai/unclog(var/mob/caller)

	for(var/k in active_ai)
		var/ai/AI = k
		if(AI.owner)
			qdel(AI.owner)
		else
			qdel(AI)
	broadcast_to_clients(span("danger","Deleted all non-boss mobs and AIs."))

	return ..()

/subsystem/ai/on_life()

	for(var/k in active_ai)
		var/ai/AI = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		if(!AI)
			log_error("Invalid AI detected. Removing...")
			active_ai -= k
			continue
		if(!AI.owner)
			log_error("WARING! AI of type [AI.type] didn't have an owner!")
			qdel(AI)
			continue
		var/should_life = AI.should_life()
		if(should_life == null || (should_life && AI.on_life(tick_rate) == null))
			log_error("WARING! AI of type [AI.type] in [AI.owner ? AI.owner.get_debug_name() : "NULL OWNER"] likely hit a runtime and was deleted, along with its owner.")
			qdel(AI.owner)

	return TRUE