#define CALLBACK(desired_id,desired_time,desired_proc,arguments...) SScallback.add_callback(desired_id,desired_time,desired_proc,arguments)

SUBSYSTEM_DEF(callback)
	name = "Callback Subsystem"
	desc = "Controls callbacks."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT
	var/list/all_callbacks = list()

/subsystem/callback/Initialize()
	return TRUE

/subsystem/callback/on_life()

	for(var/callback_id in src.all_callbacks)
		var/callback_value = src.all_callbacks[callback_id]
		if(callback_value["time"] > world.time)
			continue
		call(callback_value["proc"])(arglist(callback_value["args"]))
		src.all_callbacks -= callback_id

	return TRUE

/subsystem/callback/proc/add_callback(var/desired_id,var/desired_time,var/desired_proc,...)
	all_callbacks[desired_id] = list(
		"proc" = desired_proc,
		"args" = args.Copy(4),
		"time" = world.time + desired_time
	)
	return TRUE