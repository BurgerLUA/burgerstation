/subsystem/turfs/
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS

/subsystem/turfs/Initialize()

	set background = 1

	if(!ENABLE_TURFGEN)
		return

	var/turf_count = 0

	for(var/turf/simulated/S in world)
		S.Initialize()
		turf_count++

	LOG_SERVER("Initialized [turf_count] turfs.")
	LOG_SERVER("Stored [length(turf_icon_cache)] icons and saved [saved_icons] redundent icons.")
