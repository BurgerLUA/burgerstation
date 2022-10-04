SUBSYSTEM_DEF(healthupdate)
	name = "Health Update Subsystem"
	desc = "Controls health updating of mobs."
	priority = SS_ORDER_LAST

	tick_rate = 1

	tick_usage_max = 100

	var/list/queued_mobs = list()


/subsystem/healthupdate/on_life()

	for(var/k in queued_mobs)
		var/mob/living/L = k
		L.queue_health_update = FALSE
		src.queued_mobs -= k
		if(L.health && !L.health.qdeleting) L.health.update_health()
		if(L.queue_health_update)
			log_error("WARNING: [L.get_debug_name()] was added to the health update subsystem twice after being processed!")
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

	return TRUE