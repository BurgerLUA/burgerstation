SUBSYSTEM_DEF(callback)
	name = "Callback Subsystem"
	desc = "Controls callbacks."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT
	var/list/all_callbacks = list()

	cpu_usage_max = 0
	tick_usage_max = 0


/subsystem/callback/unclog(var/mob/caller)
	for(var/callback_id in src.all_callbacks)
		all_callbacks -= callback_id
	broadcast_to_clients(span("danger","Removed all callbacks."))
	return ..()

/subsystem/callback/proc/try_call(var/stored_object,var/stored_proc,var/stored_args)
	if(stored_object)
		call(stored_object,stored_proc)(arglist(stored_args))
	else
		call(stored_proc)(arglist(stored_args))
	return TRUE


/subsystem/callback/on_life()

	for(var/callback_id in src.all_callbacks)
		var/callback_value = src.all_callbacks[callback_id]
		if(!length(callback_value))
			CRASH_SAFE("[callback_id] had an improper callback!")
			remove_callback(callback_id)
			continue
		if(callback_value["time"] > world.time)
			continue
		var/stored_proc = callback_value["proc"]
		var/stored_args = callback_value["args"]
		var/datum/stored_object = callback_value["object"]
		src.all_callbacks -= callback_id
		if(try_call(stored_object,stored_proc,stored_args) == null)
			if(stored_object)
				log_error("Warning! Callback of id [callback_id] belonging to [stored_object] did not complete try_call() correctly, thus it was removed.")
			else
				log_error("Warning! Callback of id [callback_id] belonging to world did not complete try_call() correctly, thus it was removed.")
			all_callbacks -= callback_id

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
	if(src.all_callbacks[desired_id])
		all_callbacks -= desired_id
		return TRUE
	return FALSE