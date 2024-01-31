SUBSYSTEM_DEF(callback)
	name = "Callback Subsystem"
	desc = "Controls callbacks."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_CALLBACK
	var/list/all_callbacks = list()

	tick_usage_max = 100


/subsystem/callback/unclog(var/mob/caller)
	for(var/callback_id in src.all_callbacks)
		all_callbacks -= callback_id
	. = ..()

/subsystem/callback/proc/try_call(var/datum/stored_object,var/stored_proc,var/stored_args)
	if(stored_object)
		if(is_datum(stored_object) && stored_object.qdeleting)
			return FALSE
		call(stored_object,stored_proc)(arglist(stored_args))
	else
		call(stored_proc)(arglist(stored_args))

	return TRUE


/subsystem/callback/on_life()

	for(var/callback_id in all_callbacks)
		var/callback_value = all_callbacks[callback_id]
		if(!length(callback_value)) //Sometimes we get a race condition.
			remove_callback(callback_id)
			continue
		var/datum/stored_object = callback_value["object"]
		if(stored_object && is_datum(stored_object) && stored_object.qdeleting) //We don't do !stored_object || stored_object.qdeleting because stored_object could be null intentionally to call a world proc.
			remove_callback(callback_id)
			continue
		if(callback_value["time"] > world.time)
			//Don't put remove_callback here like I did once lmao
			continue
		remove_callback(callback_id) //The list will still exist after this.
		var/stored_proc = callback_value["proc"]
		if(!stored_proc)
			continue
		var/list/stored_args = callback_value["args"]
		var/result = try_call(stored_object,stored_proc,stored_args)
		if(isnull(result))
			if(stored_object)
				log_error("ERROR: Callback of id [callback_id] belonging to [stored_object] did not complete try_call() correctly, thus it was removed.")
			else
				log_error("ERROR: Callback of id [callback_id] belonging to world did not complete try_call() correctly, thus it was removed.")
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE

/subsystem/callback/proc/add_callback(var/desired_id,var/desired_time,var/desired_object,var/desired_proc,...)
	all_callbacks[desired_id] = list(
		"object" = desired_object,
		"proc" = desired_proc,
		"args" = args.Copy(5),
		"time" = world.time + desired_time
	)
	return TRUE

/subsystem/callback/proc/remove_callback(var/desired_id)
	if(all_callbacks[desired_id])
		all_callbacks -= desired_id
		return TRUE
	return FALSE