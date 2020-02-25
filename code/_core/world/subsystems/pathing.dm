var/global/pathfinder/pathfinder = list()

SUBSYSTEM_DEF(pathing)
	name = "Pathing Subsystem"
	desc = "Handle pathing related matters."
	priority = SS_ORDER_LAST

/subsystem/pathing/Initialize()

	LOG_SERVER("Node graph out of date. Rebuilding...")
	pathfinder = new/pathfinder(world.maxx, world.maxy, 1)

	return TRUE