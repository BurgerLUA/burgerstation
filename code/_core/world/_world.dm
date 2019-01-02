var/global/list/active_subsystems = list()
var/global/curtime = 0

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = SIDE_MAP

/world/New()
	..()
	for(var/S in subtypesof(/datum/subsystem))
		var/datum/subsystem/new_subsystem = new S
		active_subsystems += new_subsystem

	life()

/world/proc/life()
	while(TRUE)
		for(var/datum/subsystem/S in active_subsystems)
			if(!S.on_life())
				active_subsystems -= S

		curtime += TICK_LAG
		sleep(tick_lag)


