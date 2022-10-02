SUBSYSTEM_DEF(shuttle) //Also controls drop pods.
	name = "Shuttle Subsystem"
	desc = "Controls shuttles and shuttle timers."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

	cpu_usage_max = 50
	tick_usage_max = 50

	var/next_pod_respawn_time = 0

/subsystem/shuttle/Initialize()
	log_subsystem(src.name,"Found [length(all_shuttle_controlers)] shuttle controllers.")
	return ..()

/subsystem/shuttle/on_life()

	for(var/k in all_shuttle_controlers)
		var/obj/shuttle_controller/SC = k
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)
		SC.time++
		if(SC.on_shuttle_think() == null)
			log_error("Shutting down controller for [SC]([SC.x])([SC.y])([SC.z]) as on_shuttle_think returned NULL!")
			all_shuttle_controlers -= SC
			qdel(SC)

	if(next_pod_respawn_time <= world.time)
		for(var/k in drop_pod_turfs)
			var/turf/T = k
			CREATE(/obj/structure/interactive/drop_pod,T)
			drop_pod_turfs -= k
			CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)
		next_pod_respawn_time = world.time + SECONDS_TO_DECISECONDS(120)

	return TRUE