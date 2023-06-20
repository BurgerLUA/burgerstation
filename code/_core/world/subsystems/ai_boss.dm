SUBSYSTEM_DEF(bossai)
	name = "Boss AI Subsystem"
	desc = "Controls the AI of bosses."
	tick_rate = AI_TICK_FAST
	priority = SS_ORDER_FIRST

	tick_usage_max = 100

	var/list/active_ai_by_z = list()
	var/list/inactive_ai_by_z = list()

/subsystem/bossai/unclog(var/mob/caller)

	for(var/z in active_ai_by_z)
		for(var/k in active_ai_by_z[z])
			var/ai/AI = k
			active_ai_by_z[z] -= k
			if(!AI || AI.qdeleting)
				continue
			if(AI.owner)
				AI.owner.gib()
			else
				qdel(AI)

	. = ..()

/subsystem/bossai/on_life()

	for(var/z in active_ai_by_z)
		for(var/k in active_ai_by_z[z])
			var/ai/AI = k
			if(!AI)
				active_ai_by_z[z] -= k
				continue
			if(AI.qdeleting)
				log_error("WARNING: AI of type [AI.type] was qdeleting before it was removed from active_ai_by_z!")
				active_ai_by_z[z] -= k
				continue
			if(!AI.owner)
				log_error("WARNING: AI of type [AI.type] didn't have an owner!")
				qdel(AI)
				continue
			var/should_life = AI.should_life()
			if(should_life == null)
				log_error("WARNING: AI of type [AI.type] in [AI.owner.get_debug_name()] likely hit a runtime and was deleted, along with its owner.")
				qdel(AI.owner)
				continue
			if(!should_life)
				continue
			if(AI.on_life(tick_rate) == null)
				log_error("WARNING: AI of type [AI.type] in [AI.owner.get_debug_name()] likely hit a runtime and was deleted, along with its owner.")
				qdel(AI.owner)
				continue
			CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE