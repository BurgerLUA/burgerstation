/subsystem/shuttle/
	name = "Shuttle Subsystem"
	desc = "Controls shuttles and shuttle timers."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

/subsystem/shuttle/on_life()

	for(var/obj/shuttle_controller/SC in all_shuttle_controlers)
		SC.on_shuttle_think()

	return TRUE