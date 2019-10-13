/event/
	name = "event name"
	desc = "event desc"
	id = null

	var/probability = 0 //Relative probability of this event occuring.
	var/duration = 0 //In deciseconds

	var/start_time = 0
	var/end_time = 0

/event/proc/on_start()
	return TRUE

/event/proc/on_life()
	return TRUE

/event/proc/on_end()
	return TRUE