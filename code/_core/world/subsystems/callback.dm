SUBSYSTEM_DEF(callback)
	name = "Callback Subsystem"
	desc = "Controls callbacks."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT //Doesn't really matter.
	var/list/all_callbacks = list()

	tick_usage_max = 100


/subsystem/callback/unclog(var/mob/caller)
	for(var/callback_id in src.all_callbacks)
		all_callbacks -= callback_id
	broadcast_to_clients(span("danger","Removed all callbacks."))
	return ..()

/subsystem/callback/proc/try_call(var/datum/stored_object,var/stored_proc,var/stored_args)
	if(stored_object)
		if(stored_object.qdeleting)
			log_error("Warning: [stored_object.get_debug_name()] tried being called while qdeleting!")
			return FALSE
		var/result = call(stored_object,stored_proc)(arglist(stored_args))
		if(isnull(result))
			log_error("Warning: Callback proc [stored_proc] belonging to [stored_object.get_debug_name()] returned null!")
	else
		var/result = call(stored_proc)(arglist(stored_args))
		if(isnull(result))
			log_error("Warning: Callback proc [stored_proc] belonging to GLOBAL returned null!")
	return TRUE


/subsystem/callback/on_life()

	for(var/callback_id in all_callbacks)
		var/callback_value = all_callbacks[callback_id]
		if(!length(callback_value))
			//No callback data, need to remove.
			log_error("ERROR: [callback_id] had no callback data!")
			remove_callback(callback_id)
			continue
		if(callback_value["time"] > world.time)
			continue
		var/stored_proc = callback_value["proc"]
		var/list/stored_args = callback_value["args"]
		var/datum/stored_object = callback_value["object"]
		remove_callback(callback_id)
		var/result = try_call(stored_object,stored_proc,stored_args)
		if(isnull(result))
			if(stored_object)
				log_error("ERROR: Callback of id [callback_id] belonging to [stored_object] did not complete try_call() correctly, thus it was removed.")
			else
				log_error("ERROR: Callback of id [callback_id] belonging to world did not complete try_call() correctly, thus it was removed.")
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)

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