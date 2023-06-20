var/global/list/active_subsystems = list()
var/global/rollovers = 0
var/global/world_state = STATE_STARTING

#define REBOOT_TIME 60 //In seconds

/world/
	fps = FPS_SERVER
	icon_size = TILE_SIZE
	view = VIEW_RANGE
	map_format = TOPDOWN_MAP

	sleep_offline = FALSE

	name = "Burgerstation 13"
	hub = "Exadv1.spacestation13"
	hub_password = "kMZy3U5jJHSiBQjr"

	cache_lifespan = 7

	turf = /turf/dmm_suite/clear_turf
	area = /area/dmm_suite/clear_area

	maxx = 1
	maxy = 1
	maxz = 1

/world/New()

	sleep_offline = FALSE
	__detect_rust_g()

	setup_turf_damage_icons()

	//TODO: Unfuck this.
	createtypecache(/loot)
	createtypecache(/area)
	createtypecache(/area/shuttle)
	createtypecache(/mob)
	createtypecache(/mob/living)
	createtypecache(/mob/living/advanced)
	createtypecache(/mob/living/advanced/player)
	createtypecache(/mob/abstract/observer)
	createtypecache(/obj/structure)
	createtypecache(/obj/item)
	createtypecache(/obj/item/container)
	createtypecache(/obj/item/clothing)
	createtypecache(/obj/item/currency)
	createtypecache(/obj/item/organ)
	createtypecache(/obj/item/weapon)
	createtypecache(/obj/item/weapon/ranged)
	createtypecache(/obj/item/weapon/ranged/wand)
	createtypecache(/obj/item/weapon/ranged/bow)
	createtypecache(/obj/item/weapon/ranged/bullet)
	createtypecache(/obj/item/weapon/ranged/bullet/magazine)
	createtypecache(/obj/item/magazine)
	createtypecache(/obj/item/material)
	createtypecache(/obj/item/bullet_cartridge)
	createtypecache(/obj/hud)
	createtypecache(/obj/hud/inventory)
	createtypecache(/turf)
	createtypecache(/turf/simulated)
	createtypecache(/turf/simulated/floor)
	createtypecache(/turf/simulated/floor/tile)
	createtypecache(/turf/simulated/wall)
	createtypecache(/turf/simulated/liquid/water)
	createtypecache(/turf/unsimulated)
	createtypecache(/reagent/nutrition)
	. = ..()

	life()
	sleep_offline = initial(sleep_offline)

/world/proc/update_server_status()

	var/server_name = CONFIG("SERVER_NAME","Unofficial Burgerstation 13 Server")
	var/server_link = CONFIG("SERVER_DISCORD","")
	var/github_name = "SS13 <b>FROM SCRATCH</b>"
	var/duration = get_clock_time(FLOOR(true_time()/10,1),FORMAT_HOUR | FORMAT_MINUTE)
	var/description = "Gamemode: <b>[SSgamemode.active_gamemode ? SSgamemode.active_gamemode.name : "Lobby" ]</b><br>Map: <b>[SSdmm_suite.map_name ? SSdmm_suite.map_name : "Planet ([world.maxx]x[world.maxy])"]</b><br>Duration: <b>[duration]</b>"

	//Format it.
	status = "<b><a href='[server_link]'>[server_name]</a>\]</b> ([github_name])<br>[description]"

	var/player_limit_config = CONFIG("PLAYER_LIMIT",0)
	var/connected_players = length(all_clients)
	if(player_limit_config > 0 && connected_players + 10 >= player_limit_config)
		status = "[status]<br>[connected_players]/[player_limit_config] players."

	return TRUE

/world/Del()
	SSdiscord.send_message("Shutting down world...")
	return ..()

/world/proc/play_round_end_sound()
	CHECK_TICK_HARD
	var/chosen_sound = pick(SSsound.round_end_sounds)
	play_sound_global(chosen_sound,all_mobs_with_clients)
	sleep(30)
	return TRUE

/world/proc/shutdown_server()
	save()
	play_round_end_sound()
	world_state = STATE_SHUTDOWN
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C << "Shutting down world..."
	sleep(30)
	shutdown()
	return TRUE

/world/proc/reboot_server()
	save()
	play_round_end_sound()
	world_state = STATE_SHUTDOWN
	for(var/k in all_clients)
		var/client/C = all_clients[k]
		C << "Rebooting world. Stick around to automatically rejoin."
	sleep(30)
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

/proc/save_economy()
	SSeconomy.save()

/world/proc/save()
	save_all_globals()
	//save_all_mechs()
	save_deathboxes()
	save_banks()
	save_economy()
	save_all_characters()
	return TRUE

/world/proc/save_all_characters()
	for(var/k in all_players) ///Players only.
		var/mob/living/advanced/player/P = k
		if(!P)
			log_error("Warning: Tried saving a null player!")
			continue
		if(P.dead)
			continue
		if(P.qdeleting)
			log_error("Warning: Tried saving [P.get_debug_name()], which was qdeleting!")
			continue
		if(!P.ckey_last)
			if(!P.ai) log_error("Warning: Tried saving [P.get_debug_name()] without a ckey_last assigned!")
			continue
		var/savedata/client/mob/M = ckey_to_mobdata[P.ckey_last]
		if(M.save_character(P))
			P.to_chat(span("notice","Your character was automatically saved."))
		else
			P.to_chat(span("danger","Save error! Your character could not be saved!"))
		sleep(1)
		CHECK_TICK_HARD

/world/proc/end(var/reason,var/shutdown=FALSE)

	if(world_state != STATE_RUNNING)
		log_error("Can't end now!")
		return FALSE

	var/nice_reason = "Unknown reason."

	world_state = STATE_ROUND_END

	switch(reason)
		if(WORLD_END_SHUTDOWN)
			nice_reason = "Adminbus."
		if(WORLD_END_NANOTRASEN_VICTORY)
			nice_reason = "Nanotrasen Victory"
			SSpayday.stored_payday += 5000
			SSpayday.trigger_payday()
			announce("Central Command Mission Update","Mission Success","You completed all the objectives without fucking up too hard, so here is a bonus.")
		if(WORLD_END_SYNDICATE_VICTORY)
			nice_reason = "Syndicate Victory"
			announce("Central Command Mission Update","Fission Mailed","Mission failed, we'll get them next time.")

	play_sound_global('sound/meme/apcdestroyed.ogg',all_mobs_with_clients)

	//SSvote.create_vote(/vote/map)

	if(shutdown)
		broadcast_to_clients(span("notice","Shutting down world in [REBOOT_TIME] seconds due to [nice_reason]. Characters will be saved when the server shuts down."))
		CALLBACK("shutdown_world",SECONDS_TO_DECISECONDS(REBOOT_TIME),src,src::shutdown_server())
	else
		broadcast_to_clients(span("notice","Rebooting world in [REBOOT_TIME] seconds due to [nice_reason]. Characters will be saved when the server reboots."))
		CALLBACK("reboot_world",SECONDS_TO_DECISECONDS(REBOOT_TIME),src,src::reboot_server())

	SSdiscord.send_message("Round ended with [length(all_clients)] players due to [nice_reason].")

	return TRUE