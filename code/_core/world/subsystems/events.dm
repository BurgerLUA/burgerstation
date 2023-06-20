SUBSYSTEM_DEF(events)
	name = "Event Subsystem"
	desc = "Handles processing for events."
	priority = SS_ORDER_FIRST
	tick_rate = SECONDS_TO_TICKS(5)

	var/list/all_events = list()

	var/list/all_events_minor_prob = list()
	var/list/all_events_major_prob = list()

	var/list/all_events_active = list()

	var/next_event_minor = 0 //No announcement.
	var/next_event_major = 0 //Has announcement.

	var/enable = FALSE

/subsystem/events/unclog(var/mob/caller)

	for(var/k in all_events_active)
		var/event/E = k
		all_events_active -= k
		if(!E || E.qdeleting)
			continue
		qdel(E)

	. = ..()

/subsystem/events/Initialize()

	for(var/k in subtypesof(/event/))
		var/event/E = new k
		all_events[E.type] = E
		if(E.minor_event)
			all_events_minor_prob[E.type] = E.probability
		else
			all_events_major_prob[E.type] = E.probability

	next_event_minor = world.time + SECONDS_TO_DECISECONDS(300)
	next_event_major = world.time + SECONDS_TO_DECISECONDS(600)

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

	if(!enable)
		next_event_minor = world.time + SECONDS_TO_DECISECONDS(300)
		next_event_major = world.time + SECONDS_TO_DECISECONDS(600)
		return TRUE

	for(var/k in all_events_active)
		var/event/E = k
		if(!E || E.qdeleting)
			all_events_active -= k
			continue
		if(process_event(E) == null)
			all_events_active -= E
			qdel(E)
			log_error("Warning! Event of type [E.type] did not process correctly, thus it was deleted.")
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	if(world.time >= next_event_minor)
		trigger_random_event(TRUE)

	if(world.time >= next_event_major)
		trigger_random_event(FALSE)

	return TRUE

/subsystem/events/proc/trigger_random_event(var/minor)

	if(!SSgamemode?.active_gamemode?.allow_launch)
		return FALSE

	var/event_id

	if(minor && length(all_events_minor_prob))
		event_id = pickweight(all_events_minor_prob)
	else if(!minor && length(all_events_major_prob))
		event_id = pickweight(all_events_major_prob)

	if(!event_id)
		return FALSE

	var/event/E = all_events[event_id]

	log_debug("Triggering [E.get_debug_name()] in 5 seconds...")

	next_event_minor = max(next_event_minor,world.time + 100)
	next_event_major = max(next_event_major,world.time + 100)

	CALLBACK("trigger_event",50,src,src::trigger_event(),E)

	return TRUE

/subsystem/events/proc/trigger_event(var/event/E)

	if(E.active)
		return FALSE

	if(!E.on_start())
		E.on_fail()
		next_event_minor = max(next_event_minor,world.time + 30)
		next_event_major = max(next_event_major,world.time + 30)
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

	next_event_minor = E.minor_event ? world.time + SECONDS_TO_DECISECONDS(rand(120,300)) : max(next_event_minor,world.time + SECONDS_TO_DECISECONDS(60))
	next_event_major = !E.minor_event ? world.time + SECONDS_TO_DECISECONDS(rand(600,900)) : max(next_event_major,world.time + SECONDS_TO_DECISECONDS(60))

	E.occurances_current++

	if(E.occurances_current >= E.occurances_max)
		all_events -= E.type
		all_events_minor_prob -= E.type
		all_events_major_prob -= E.type

	return E





