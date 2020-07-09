var/global/list/active_subsystems = list()
var/global/ticks = 0
var/global/rollovers = 0
var/global/world_state = STATE_STARTING

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = TOPDOWN_MAP
	sleep_offline = TRUE

	name = "Burgerstation 13"
	hub = "Exadv1.spacestation13"
	hub_password = "kMZy3U5jJHSiBQjr"

	cache_lifespan = 5

	//maxx = WORLD_SIZE
	//maxy = WORLD_SIZE
	//maxz = 1

	turf = /turf/unsimulated/space
	area = /area/

	loop_checks = 0

/world/New()
	..()
	life()

/world/proc/update_server_status()

	if(world_state == STATE_STARTING)
		return FALSE

	var/server_name = CONFIG("SERVER_NAME","Unofficial Burgerstation 13 Server")
	var/server_link = CONFIG("SERVER_DISCORD","https://discord.gg/a2wHSqu")
	var/github_name = "SS13 <b>FROM SCRATCH</b>"
	var/description = CONFIG("SERVER_DESCRIPTION","No description provided.")

	/*
	var/minutes = FLOOR(world.time / 600, 1)
	var/hours = FLOOR(world.time / 36000, 1)

	if(minutes < 10)
		minutes = "0[minutes]"

	var/duration = "[hours]:[minutes]"
	var/map = "Biomes"
	*/

	//Format it.
	status = "<b><a href='[server_link]'>[server_name]</a>\]</b> ([github_name])<br>"
	status += "<i>[description]</i><br>"
	//status += "Map: <b>[map]</b><br>"
	//status += "Time: <b>\[[duration]</b>"

/*
/world/Error(var/exception/e)
	var/name = e.name
	var/file = e.file
	var/line = e.line
	var/desc = e.desc

	broadcast_to_role("<span class='system error'>Runtime Error!<br>[name] at line [line] at [file]<br>[desc]</span>",TEXT_OOC,FLAG_PERMISSION_DEVELOPER)

	return TRUE
*/

/world/proc/shutdown_server()
	world_state = STATE_SHUTDOWN
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C << "Shutting down world..."
	shutdown()
	return TRUE


/world/proc/reboot_server()
	world_state = STATE_SHUTDOWN
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C << "Rebooting world. Stick around to automatically rejoin."
	Reboot(0)
	return TRUE

/world/proc/end(var/reason,var/shutdown=FALSE)

	if(world_state != STATE_RUNNING)
		CRASH_SAFE("Can't restart now!")
		return FALSE

	var/nice_reason = "Unknown reason."

	world_state = STATE_ROUND_END

	switch(reason)
		if(WORLD_END_SHUTDOWN)
			nice_reason = "Adminbus."
		if(WORLD_END_NANOTRASEN_VICTORY)
			nice_reason = "Nanotrasen Victory"
			SSpayday.stored_payday += 10000
			SSpayday.trigger_payday()
			announce("Central Command","Mission Success","You completed all the objectives without fucking up too hard, so here is a bonus.")
		if(WORLD_END_SYNDICATE_VICTORY)
			nice_reason = "Syndicate Victory"
			announce("Central Command","Fission Mailed","Mission failed, we'll get them next time.")

	play('sound/meme/apcdestroyed.ogg',all_mobs_with_clients)

	for(var/mob/living/advanced/player/P in all_players)
		CHECK_TICK
		if(P.dead)
			P.to_chat("Could not save your character because you were dead.")
			continue
		var/savedata/client/mob/mobdata = MOBDATA(P.ckey_last)
		mobdata.save_character(P,force = TRUE)
		P.to_chat("Your character was automatically saved.")
		sleep(1)

	if(shutdown)
		broadcast_to_clients(span("notice","Shutting down world in 60 seconds down the world due to [nice_reason]."))
		CALLBACK("shutdown_world",SECONDS_TO_DECISECONDS(60),src,.proc/shutdown_server)
	else
		broadcast_to_clients(span("notice","Rebooting world in 60 seconds down the world due to [nice_reason]."))
		CALLBACK("reboot_world",SECONDS_TO_DECISECONDS(60),src,.proc/reboot_server)


	return TRUE