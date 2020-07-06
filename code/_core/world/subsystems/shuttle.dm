SUBSYSTEM_DEF(shuttle)
	name = "Shuttle Subsystem"
	desc = "Controls shuttles and shuttle timers."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

/subsystem/shuttle/Initialize()

	log_subsystem(src.name,"Found [length(all_shuttle_controlers)] shuttle controllers.")

	return ..()

/subsystem/shuttle/on_life()

	for(var/obj/shuttle_controller/SC in all_shuttle_controlers)
		SC.time++
		if(!SC.on_shuttle_think())
			log_error("Shutting down controller for [SC]([SC.x])([SC.y])([SC.z]) as on_shuttle_think returned FALSE!")
			all_shuttle_controlers -= SC

	return ..()