SUBSYSTEM_DEF(client)
	name = "Client Subsystem"
	desc = "Controls how clients behave."
	tick_rate = CLIENT_TICK
	priority = SS_ORDER_PRELOAD

	var/advanced_ticks = 0

	tick_usage_max = 100

	use_time_dialation = FALSE

	var/list/queued_automatics = list()

/subsystem/client/unclog(var/mob/caller)
	for(var/ckey in all_clients) //This should never be tick checked.
		var/client/C = all_clients[ckey]
		if(!C)
			all_clients -= ckey
			continue
	. = ..()

/subsystem/client/on_life()

	advanced_ticks += 1

	var/do_slow = FALSE

	if(advanced_ticks >= CLIENT_TICKS_PER_SLOW_CLIENT_TICKS)
		do_slow = TRUE
		advanced_ticks = 0

	//This handles life ticks for all players.
	for(var/ckey in all_clients) //This should never be tick checked.
		var/client/C = all_clients[ckey]
		if(!C)
			log_error("Tried getting the client of [ckey] but it didn't exist!")
			all_clients -= ckey
			continue
		C.on_life()
		if(do_slow)
			C.on_life_slow()
		if(world_state >= STATE_RUNNING)
			CHECK_TICK(tick_usage_max,FPS_SERVER)

	for(var/k in queued_automatics)
		var/obj/item/weapon/ranged/R = k
		var/list/data = queued_automatics[k]
		if(!data || !length(data))
			queued_automatics -= k
			continue
		var/mob/caller = data[1]
		var/list/params = data[2]
		var/damage_multiplier = data[3]
		var/max_bursts_to_use = data[4]
		var/shoot_delay_to_use = data[5]
		if(R.next_shoot_time > world.time)
			continue
		if(!R.handle_automatic(caller,params,damage_multiplier,max_bursts_to_use,shoot_delay_to_use))
			var/real_burst_delay = (R.burst_delay ? R.burst_delay : R.shoot_delay*R.current_bursts*1.25) - R.shoot_delay*R.current_bursts
			R.next_shoot_time = max(R.next_shoot_time,world.time + real_burst_delay)
			R.current_bursts = 1
			queued_automatics -= k
		CHECK_TICK(tick_usage_max,FPS_SERVER)


	return TRUE