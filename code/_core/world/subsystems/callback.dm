SUBSYSTEM_DEF(callback)
	name = "Callback Subsystem"
	desc = "Controls callbacks."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT
	var/list/all_callbacks = list()

	cpu_usage_max = 100
	tick_usage_max = 100

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
		try
			if(stored_object)
				call(stored_object,stored_proc)(arglist(stored_args))
			else
				call(stored_proc)(arglist(stored_args))
		catch(var/exception/e)
			log_error("SScallback: [e] on [e.file]:[e.line]!")

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