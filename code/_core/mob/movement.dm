/mob/proc/can_sprint()
	return movement_flags & MOVEMENT_RUNNING

/mob/proc/on_sprint()
	return TRUE

/mob/proc/can_walk()
	return movement_flags & MOVEMENT_WALKING

/mob/proc/on_walk()
	return TRUE

/mob/get_movement_delay()

	. = ..()

	if(can_walk())
		. *= 2
		on_walk()

	else if(can_sprint())
		. *= 0.75
		on_sprint()

	return .