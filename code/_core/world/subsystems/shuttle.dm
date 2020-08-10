SUBSYSTEM_DEF(shuttle)
	name = "Shuttle Subsystem"
	desc = "Controls shuttles and shuttle timers."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

	cpu_usage_max = 50
	tick_usage_max = 50

/subsystem/shuttle/Initialize()

	log_subsystem(src.name,"Found [length(all_shuttle_controlers)] shuttle controllers.")

	return ..()

/subsystem/shuttle/on_life()

	for(var/k in all_shuttle_controlers)
		var/obj/shuttle_controller/SC = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		SC.time++
		if(!SC.on_shuttle_think())
			log_error("Shutting down controller for [SC]([SC.x])([SC.y])([SC.z]) as on_shuttle_think returned FALSE!")
			all_shuttle_controlers -= SC

	return ..()