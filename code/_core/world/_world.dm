#define TICK_CHECK if(tick_usage_average >= 80) sleep(1)

var/global/list/active_subsystems
var/global/curtime = 0
var/global/ticks = 0
var/global/tick_usage_average = 0

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = TOPDOWN_MAP

	name = "Burgerstation 13"
	hub = "Exadv1.spacestation13"
	hub_password = "kMZy3U5jJHSiBQjr"

	cache_lifespan = 0



/world/New()
	log = file("logs/mylog.txt")
	..()
	life()

/world/proc/update_status()

	var/server_name = "Burgerstation 13 RPG"
	var/server_link = "https://discord.gg/yEaV92a"
	var/github_name = "Space Station 13 Code <b>FROM SCRATCH</b>"

	var/minutes = floor(curtime / 600) % 60
	var/hours = floor(curtime / 12000)

	if(minutes < 10)
		minutes = "0[minutes]"

	var/duration = "[hours]:[minutes]"
	var/map = "Nar'sie's Realm (128x128x10)"

	//Format it.
	status = "<a href='[server_link]'><b>[server_name]</b></a>] ([github_name])<br><br>"
	status += "Map: <b>[map]</b><br>"
	status += "Round Duration: <b>[duration]</b>"

/world/proc/life()
	set background = TRUE

	world.log << "STARTING WORLD."

	active_subsystems = new(SS_ORDER_SIZE)

	update_status()

	for(var/S in subtypesof(/subsystem/))
		var/subsystem/new_subsystem = new S
		if(!new_subsystem.priority)
			qdel(S)
			continue
		active_subsystems[new_subsystem.priority] = new_subsystem

	var/benchmark = world.timeofday

	for(var/subsystem/S in active_subsystems)
		var/local_benchmark = world.timeofday
		S.Initialize()
		world.log << "[S.name] Initialization: Took [DECISECONDS_TO_SECONDS((world.timeofday - local_benchmark))] seconds."

	world.log << "All initializations took [DECISECONDS_TO_SECONDS((world.timeofday - benchmark))] seconds."

	spawn while(TRUE)
		for(var/subsystem/S in active_subsystems)
			if(S.next_run <= ticks)
				if(!S.tick_rate || !S.on_life())
					active_subsystems -= S
					qdel(S)
					continue
				S.next_run = ticks + S.tick_rate

		curtime = round(curtime + TICK_LAG,TICK_LAG)
		ticks += 1
		tick_usage_average = (tick_usage_average+tick_usage)/2

		var/sleep_time = max(tick_lag,tick_usage*tick_lag*0.01)

		sleep(sleep_time)


