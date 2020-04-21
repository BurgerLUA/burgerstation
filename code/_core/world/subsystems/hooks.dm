SUBSYSTEM_DEF(hook)
	name = "Enviromental Hazard Subsystem"
	desc = "Controls hazards, like extreme cold or extreme heat."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

/subsystem/hook/Initialize()
	return TRUE

/subsystem/hook/on_life()
	return TRUE

//GMOD, anyone? Doesn't need a priority var as people should just add/overwrite the proc it calls.
//Adds a hook to an event.
/subsystem/hook/proc/add_hook(var/event_name,var/identifier,var/datum/datum_to_use,var/proc_to_use)

	ASSERT(datum_to_use)

	if(!datum_to_use.hooks)
		datum_to_use.hooks = list()

	if(!datum_to_use.hooks[event_name])
		datum_to_use.hooks[event_name] = list()

	datum_to_use.hooks[event_name][identifier] = proc_to_use

	return TRUE

/subsystem/hook/proc/remove_hook(var/event_name,var/identifier,var/datum/datum_to_use)

	ASSERT(datum_to_use)

	if(!datum_to_use.hooks)
		return FALSE

	if(!datum_to_use.hooks[event_name])
		return FALSE

	if(!datum_to_use.hooks[event_name][identifier])
		return FALSE

	datum_to_use.hooks[event_name] -= identifier

	return TRUE

/subsystem/hook/proc/call_hook(var/event_name,var/datum/datum_to_use,var/args)

	ASSERT(event_name)

	if(!datum_to_use.hooks)
		return FALSE

	if(!datum_to_use.hooks[event_name])
		return FALSE

	var/total_calls = 0

	for(var/identifier in datum_to_use.hooks[event_name])
		var/proc_to_use = datum_to_use.hooks[event_name][identifier]
		call(datum_to_use,proc_to_use)(args)
		total_calls++

	return total_calls



