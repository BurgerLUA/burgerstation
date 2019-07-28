var/global/list/active_subsystems
var/global/curtime = 0
var/global/ticks = 0

var/global/world_state = STATE_STARTING

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = TOPDOWN_MAP

	name = "Burgerstation 13"
	hub = "Exadv1.spacestation13"
	hub_password = "kMZy3U5jJHSiBQjr"

	cache_lifespan = 0

	maxx = WORLD_SIZE
	maxy = WORLD_SIZE
	maxz = 1

	turf = /turf/unsimulated/


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
	var/map = "Nar'sie's Realm ([WORLD_SIZE]x[WORLD_SIZE]x1)"

	//Format it.
	status = "<a href='[server_link]'><b>[server_name]</b></a>] ([github_name])<br><br>"
	status += "Map: <b>[map]</b><br>"
	status += "Round Duration: <b>[duration]</b>"


/world/Error(var/exception/e)
	var/name = e.name
	var/file = e.file
	var/line = e.line
	var/desc = e.desc

	var/final_text = "<span class='system error'>Runtime Error!<br>[name] at line [line] at [file]<br>[desc]</span>"

	broadcast_to_role(final_text,TEXT_OOC,FLAG_PERMISSION_DEVELOPER)

	return TRUE