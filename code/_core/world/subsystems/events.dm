SUBSYSTEM_DEF(events)
	name = "Event Subsystem"
	desc = "Stores all the known dialogue in a list."
	priority = SS_ORDER_NORMAL
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/all_events = list()
	var/list/all_events_prob = list()
	var/list/all_events_active = list()

	var/next_event_time = 0

/subsystem/events/Initialize()

	for(var/k in subtypesof(/event/))
		var/event/E = new k
		all_events[E.type] = E
		all_events_prob[E.type] = E.probability

	next_event_time = world.time + SECONDS_TO_DECISECONDS(1200)

	return ..()

/subsystem/events/on_life()

	for(var/k in all_events_active)
		var/event/E = k
		if(E.end_time <= world.time)
			E.on_end()
			E.active = FALSE
			all_events_active -= E
		else
			E.on_life()

	if(world.time >= next_event_time)
		trigger_random_event()

	return ..()

/subsystem/events/proc/trigger_random_event()

	if(!length(all_events_prob))
		return FALSE

	var/event_id = pickweight(all_events_prob)

	var/event/E = all_events[event_id]
	if(E.active)
		return FALSE

	if(!E.on_start())
		E.on_fail()
		next_event_time = world.time + 20
		return FALSE

	if(E.duration)
		all_events_active += E
		E.active = TRUE
		E.start_time = world.time
		E.end_time = world.time + E.duration
		next_event_time = world.time + SECONDS_TO_DECISECONDS(rand(600,900)) + E.duration
	else
		E.on_end()
		next_event_time = world.time + SECONDS_TO_DECISECONDS(rand(600,900))

	if(E.occurances_current >= E.occurances_max)
		all_events -= E
		all_events_prob -= E

	return E






