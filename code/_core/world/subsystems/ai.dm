SUBSYSTEM_DEF(ai)
	name = "AI Subsystem"
	desc = "Controls the AI of mobs."
	priority = SS_ORDER_FIRST

	var/list/active_ai_by_z = list()
	var/list/inactive_ai_by_z = list()

	var/list/tracked_avoidance_by_z = list()

	use_time_dialation = FALSE

	tick_rate = AI_TICK

	tick_usage_max = 95

	var/list/queued_ai_update_chunks = list()

	var/next_chunk_update = 0

/subsystem/ai/unclog(var/mob/caller)

	for(var/z in active_ai_by_z)
		for(var/k in active_ai_by_z[z])
			var/ai/AI = k
			active_ai_by_z[z] -= k
			if(!AI || AI.qdeleting)
				continue
			if(AI.owner)
				AI.owner.gib() //Makes items drop.
			else
				qdel(AI)

	. = ..()

/subsystem/ai/on_life()

	if(next_chunk_update < world.time)
		next_chunk_update = world.time + SECONDS_TO_DECISECONDS(2)
		for(var/ch in queued_ai_update_chunks)
			var/chunk/C1 = ch
			queued_ai_update_chunks -= ch
			for(var/j in C1.ai)
				var/ai/A = j
				if(!A.active) A.set_active(TRUE)
			for(var/k in C1.adjacent_chunks)
				var/chunk/C2 = k
				for(var/j in C2.ai)
					var/ai/A = j
					if(!A.active) A.set_active(TRUE)

	for(var/z in active_ai_by_z)
		for(var/k in active_ai_by_z[z])
			var/ai/AI = k
			if(!AI)
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
				log_error("WARNING: AI of type [AI.type] in [AI.owner ? AI.owner.get_debug_name() : "NULL OWNER"] likely hit a runtime and was deleted, along with its owner.")
				if(AI.owner)
					qdel(AI.owner)
				continue
			if(!should_life)
				continue
			if(AI.on_life(tick_rate) == null)
				log_error("WARNING: AI of type [AI.type] in [AI.owner ? AI.owner.get_debug_name() : "NULL OWNER"] likely hit a runtime and was deleted, along with its owner.")
				if(AI.owner)
					qdel(AI.owner)
				continue
			CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE