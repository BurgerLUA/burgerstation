var/global/list/active_subsystems = list()
var/global/ticks = 0
var/global/rollovers = 0
var/global/world_state = STATE_STARTING

#define REBOOT_TIME 60 //In seconds

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = TOPDOWN_MAP
	sleep_offline = TRUE

	name = "Burgerstation 13"
	hub = "Exadv1.spacestation13"
	hub_password = "kMZy3U5jJHSiBQjr"

	cache_lifespan = 7

	turf = /turf/space
	area = /area/

	maxx = WORLD_SIZE
	maxy = WORLD_SIZE
	maxz = 0

	loop_checks = 1

/world/New()
	__detect_rust_g()
	..()
	life()

/world/proc/update_server_status()

	if(world_state == STATE_STARTING)
		return FALSE

	var/server_name = CONFIG("SERVER_NAME","Unofficial Burgerstation 13 Server")
	var/server_link = CONFIG("SERVER_DISCORD","https://discord.gg/a2wHSqu")
	var/github_name = "SS13 <b>FROM SCRATCH</b>"

	var/minutes = FLOOR(world.time / 600, 1)
	var/hours = FLOOR(world.time / 36000, 1)
	if(minutes < 10)
		minutes = "0[minutes]"
	var/duration = "[hours]:[minutes]"

	var/description = "Gamemode: <b>[SSgamemode.active_gamemode ? SSgamemode.active_gamemode.name : "Lobby" ]</b><br>Map: <b>[SSdmm_suite.map_name ? SSdmm_suite.map_name : "Loading..."]</b><br>Duration: <b>[duration]</b>"

	//Format it.
	status = "<b><a href='[server_link]'>[server_name]</a>\]</b> ([github_name])<br>[description]"

	var/player_limit_config = CONFIG("PLAYER_LIMIT",0)
	var/connected_players = length(all_clients)
	if(player_limit_config > 0 && connected_players + 10 >= player_limit_config)
		status = "[status]<br>[connected_players]/[player_limit_config] players."

	return TRUE


/world/Error(var/exception/e)
	log_error("[e.name] in [e.file]:[e.line].\n[e.desc]")

	for(var/k in all_runtimes)
		var/mob/living/simple/cat/runtime/R = k
		if(R.qdeleting)
			all_runtimes -= k
			continue
		R.reproduce()

	return TRUE

/world/Del()
	SSdiscord.send_message("Shutting down world...")
	return ..()

/world/proc/shutdown_server()
	save()
	world_state = STATE_SHUTDOWN
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C << "Shutting down world..."
	sleep(30)
	shutdown()
	return TRUE

/world/proc/reboot_server()
	save()
	world_state = STATE_SHUTDOWN
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C << "Rebooting world. Stick around to automatically rejoin."
	sleep(0)
	Reboot(0)
	return TRUE

/proc/save_all_globals()
	for(var/k in all_clients)
		var/client/C = CLIENT(k)
		if(!C)
			log_error("FATAL ERROR: COULD NOT SAVE THE GLOBALS OF CKEY [k] AS THEY HAD A CKEY ISSUE.")
			continue
		var/savedata/client/globals/G = GLOBALDATA(k)
		if(!G)
			log_error("FATAL ERROR: COULD NOT SAVE THE GLOBALS OF CKEY [k] AS THEY DID NOT HAVE A GLOBAL ASSIGNED.")
			continue
		G.save()

/world/proc/save()
	save_all_globals()
	//save_all_mechs()
	save_all_globals()
	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		if(P.dead)
			P.to_chat(span("danger","Could not save your character because you were dead."))
			continue
		var/savedata/client/mob/mobdata = MOBDATA(P.ckey_last)
		mobdata.save_character(P,force = TRUE)
		P.to_chat(span("notice","Your character was automatically saved."))
		sleep(-1)
	var/chosen_sound = pick(SSsound.round_end_sounds)
	play_sound_global(chosen_sound,all_mobs_with_clients)
	sleep(100)
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
			announce("Central Command Mission Update","Mission Success","You completed all the objectives without fucking up too hard, so here is a bonus.")
		if(WORLD_END_SYNDICATE_VICTORY)
			nice_reason = "Syndicate Victory"
			announce("Central Command Mission Update","Fission Mailed","Mission failed, we'll get them next time.")

	play_sound_global('sound/meme/apcdestroyed.ogg',all_mobs_with_clients)

	SSvote.create_vote(/vote/map)

	if(shutdown)
		broadcast_to_clients(span("notice","Shutting down world in [REBOOT_TIME] seconds due to [nice_reason]. Characters will be saved when the server shuts down."))
		CALLBACK("shutdown_world",SECONDS_TO_DECISECONDS(REBOOT_TIME),src,.proc/shutdown_server)
	else
		broadcast_to_clients(span("notice","Rebooting world in [REBOOT_TIME] seconds due to [nice_reason]. Characters will be saved when the server reboots."))
		CALLBACK("reboot_world",SECONDS_TO_DECISECONDS(REBOOT_TIME),src,.proc/reboot_server)

	SSdiscord.send_message("Round ended due to [nice_reason].")

	return TRUE