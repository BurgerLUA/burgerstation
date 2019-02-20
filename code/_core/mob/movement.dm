/mob/proc/can_sprint()
	return movement_flags & MOVEMENT_RUNNING || move_mod == 3

/mob/proc/on_sprint()
	return TRUE

/mob/proc/can_walk()
	return movement_flags & MOVEMENT_WALKING || move_mod == 1

/mob/proc/on_walk()
	return TRUE

/mob/get_movement_delay()

	. = ..()

	if(can_sprint())
		. *= 0.75
		on_sprint()

	else if(can_walk())
		. *= 1.25
		on_walk()

	return .