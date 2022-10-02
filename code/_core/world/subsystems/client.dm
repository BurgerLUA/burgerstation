SUBSYSTEM_DEF(client)
	name = "Client Subsystem"
	desc = "Controls how clients behave."
	tick_rate = CLIENT_TICK
	priority = SS_ORDER_PRELOAD

	var/advanced_ticks = 0

	cpu_usage_max = 100
	tick_usage_max = 100

	use_time_dialation = FALSE

	var/list/queued_automatics = list()

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
		CHECK_TICK_HARD(DESIRED_TICK_LIMIT)

	for(var/k in queued_automatics)
		var/obj/item/weapon/ranged/R = k
		var/list/data = queued_automatics[k]
		var/mob/caller = data[1]
		var/list/params = data[2]
		var/damage_multiplier = data[3]
		var/max_bursts_to_use = data[4]
		var/shoot_delay_to_use = data[5]
		if(R.last_shoot_time + shoot_delay_to_use > world.time)
			continue
		if(!R.handle_automatic(caller,params,damage_multiplier,max_bursts_to_use,shoot_delay_to_use))
			R.next_shoot_time = world.time + (R.burst_delay ? R.burst_delay : R.shoot_delay*R.current_bursts*1.25)
			R.current_bursts = 1
			queued_automatics -= k


	return TRUE