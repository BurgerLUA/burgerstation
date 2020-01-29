/subsystem/obj/
	name = "Objs Subsystem"
	desc = "Initialize objs after they are made."
	priority = SS_ORDER_OBJS

/subsystem/obj/Initialize()

	set background = 1

	var/obj_count = 0

	for(var/obj/O in world)
		if(O.initialized)
			continue
		O.Initialize()
		obj_count++

	LOG_SERVER("Initialized [obj_count] objects.")
