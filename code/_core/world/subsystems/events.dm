

SUBSYSTEM_DEF(events)
	name = "Event Subsystem"
	desc = "Stores all the known dialogue in a list."
	priority = SS_ORDER_NORMAL
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/all_events = list()
	var/list/all_events_prob = list()
	var/list/all_events_active = list()

	var/ticks_unit_trigger = 300

/subsystem/events/Initialize()

	for(var/k in subtypesof(/event/))
		var/event/E = new k
		all_events[E.type] = E
		all_events_prob[E.type] = E.probability

/subsystem/events/on_life()

	for(var/event/E in all_events_active)
		if(E.end_time <= world.time)
			E.on_end()
			all_events_active -= E
		else
			E.on_life()

	if(ticks_unit_trigger <= 0)
		trigger_random_event()
		ticks_unit_trigger = initial(ticks_unit_trigger)

	ticks_unit_trigger -= 1

	return TRUE

/subsystem/events/proc/trigger_random_event()
	var/event_id = pickweight(all_events_prob)

	if(!event_id)
		LOG_DEBUG("There are [length(all_events_prob)] events!")
		return FALSE

	var/event/E = all_events[event_id]
	E.on_start()
	if(E.duration)
		all_events_active += E
		E.start_time = world.time
		E.end_time = world.time + E.duration

	return E






