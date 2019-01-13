var/global/list/active_subsystems
var/global/curtime = 0
var/global/ticks = 0

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = SIDE_MAP

/world/New()
	..()
	life()

/world/proc/life()
	set background = TRUE

	active_subsystems = new(SS_ORDER_SIZE)

	for(var/S in subtypesof(/datum/subsystem))
		var/datum/subsystem/new_subsystem = new S
		if(!new_subsystem.priority)
			del(S)
			continue
		active_subsystems[new_subsystem.priority] = new_subsystem

	spawn while(TRUE)
		for(var/datum/subsystem/S in active_subsystems)
			if(!S.tick_rate || S.next_run <= ticks)
				if(!S.on_life())
					del(S)
					continue
				S.next_run = ticks + S.tick_rate

		curtime += TICK_LAG
		ticks += 1
		sleep(tick_lag)


