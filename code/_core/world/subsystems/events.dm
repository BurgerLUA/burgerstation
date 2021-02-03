SUBSYSTEM_DEF(events)
	name = "Event Subsystem"
	desc = "Handles processing for events."
	priority = SS_ORDER_NORMAL
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/all_events = list()
	var/list/all_events_prob = list()
	var/list/all_events_active = list()

	var/next_event_time = 0

/subsystem/events/unclog(var/mob/caller)

	for(var/k in all_events_active)
		var/datum/D = k
		all_events_active -= k
		qdel(D)

	broadcast_to_clients(span("danger","Force ended all active events and shutdown the event subsystem."))

	return ..()

/subsystem/events/Initialize()

	for(var/k in subtypesof(/event/))
		var/event/E = new k
		all_events[E.type] = E
		all_events_prob[E.type] = E.probability

	next_event_time = world.time + SECONDS_TO_DECISECONDS(600)

	return ..()

/subsystem/events/proc/process_event(var/event/E)
	if(E.end_time != -1 && E.end_time <= world.time)
		E.on_end()
		E.active = FALSE
		all_events_active -= E
	else
		E.on_life()
	return TRUE

/subsystem/events/on_life()

	for(var/k in all_events_active)
		var/event/E = k
		if(process_event(E) == null)
			all_events_active -= E
			qdel(E)
			log_error("Warning! Event of type [E.type] did not process correctly, thus it was deleted.")

	if(world.time >= next_event_time)
		trigger_random_event()

	return TRUE

/subsystem/events/proc/trigger_random_event()

	if(!length(all_events_prob))
		return FALSE

	var/event_id = pickweight(all_events_prob)

	var/event/E = all_events[event_id]

	log_debug("Triggering [E.get_debug_name()] in 5 seconds...")

	CALLBACK("trigger_event",50,src,.proc/trigger_event,E)
	next_event_time = world.time + 200 //In case it doesn't trigger.

	return TRUE

/subsystem/events/proc/trigger_event(var/event/E)

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
		if(E.duration == -1)
			E.end_time = -1
		else
			E.end_time = world.time + E.duration
	else
		E.on_end()

	next_event_time = world.time + SECONDS_TO_DECISECONDS(rand(600,900))

	E.occurances_current++

	if(E.occurances_current >= E.occurances_max)
		all_events -= E.type
		all_events_prob -= E.type

	return E





