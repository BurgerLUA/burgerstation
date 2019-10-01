/subsystem/turfs/
	name = "Turf Subsystem"
	desc = "Manage turfs."
	priority = SS_ORDER_TURFS

/subsystem/turfs/Initialize()

	set background = 1

	if(!ENABLE_TURFGEN)
		return

	var/turf_count = 0
	var/area_count = 0
	var/smooth_count = 0

	for(var/area/A in world)
		A.Initialize()
		area_count++

	LOG_SERVER("Initialized [area_count] areas.")

	for(var/turf/simulated/S in world)
		S.Initialize()
		turf_count++

	LOG_SERVER("Initialized [turf_count] turfs.")

	for(var/obj/structure/smooth/S in world)
		S.Initialize()
		smooth_count++

	LOG_SERVER("Initialized [smooth_count] smooth structures.")


