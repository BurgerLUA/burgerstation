/event/
	var/name = "event name"

	var/active = FALSE

	var/probability = 0 //Relative probability of this event occuring.
	var/duration = 0 //How long does this event process for, in deciseconds. Set to -1 to make it end when it wants to end.

	var/start_time = 0
	var/end_time = 0

	var/lifetime = 0 //How long as this event been triggering for? In deciseconds.

	var/occurances_current = 0
	var/occurances_max = 3

	var/list/gamemode_blacklist = list(


	)

/event/proc/force_end()
	end_time = 0
	return TRUE

/event/proc/on_start()
	lifetime = 0
	return TRUE

/event/proc/on_life()
	lifetime += TICKS_TO_DECISECONDS(SSevents.tick_rate)
	return TRUE

/event/proc/on_end()
	return TRUE

/event/proc/on_fail()
	return TRUE