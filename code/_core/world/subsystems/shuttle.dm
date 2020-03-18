SUBSYSTEM_DEF(shuttle)
	name = "Shuttle Subsystem"
	desc = "Controls shuttles and shuttle timers."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

/subsystem/shuttle/on_life()

	for(var/obj/shuttle_controller/SC in all_shuttle_controlers)
		SC.time++
		if(!SC.on_shuttle_think())
			LOG_ERROR("Shutting down controller for [SC]!")
			all_shuttle_controlers -= SC

	return TRUE