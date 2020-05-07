/client/verb/trigger_shutdown()
	set name = "Shutdown"
	set category = "Server"
	world.safe_shutdown()
	return TRUE

/world/proc/safe_shutdown()
	var/start_time = world.time
	if(usr)
		broadcast_to_clients("<b>Shutdown called by [usr]!</b>")
		LOG_ADMIN("Shutdown called by [usr]!")
	broadcast_to_clients("<b>Server shutting down...</b>")
	world_state = STATE_SHUTDOWN
	broadcast_to_clients("<b>Saving all characters...</b>")
	for(var/mob/living/advanced/player/P in all_players)
		if(P.dead)
			continue
		P.mobdata.save_current_character()
	broadcast_to_clients("<b>All characters saved.</b>")

	broadcast_to_clients("<b>Shutdown complete. Took [DECISECONDS_TO_SECONDS(world.time - start_time)] seconds.</b>")
	sleep(30)
	del(src)

	return TRUE