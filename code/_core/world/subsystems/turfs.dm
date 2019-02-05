/subsystem/turfs/
	name = "Turf Subsystem"
	desc = "Manage turfs."
	priority = SS_ORDER_TURFS

/subsystem/turfs/on_life()
	for(var/turf/simulated/S in world)
		S.Initialize()

	for(var/obj/structure/smooth/S in world)
		S.Initialize()

	return FALSE