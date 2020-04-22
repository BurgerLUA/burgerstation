
/*
obj/structure/interactive/door/airlock/open(var/unlock = FALSE, var/force = FALSE)

	if(locked && (unlock || force))
		unlock()

	if(door_state != DOOR_STATE_CLOSED)
		return FALSE

	if(door_state == DOOR_STATE_DENY)
		return FALSE

	if(locked)
		return FALSE

	spawn()

		if(!force && no_access)
			door_state = DOOR_STATE_DENY
			update_sprite()
			sleep(10)
			door_state = DOOR_STATE_CLOSED
			update_sprite()
			return

		if(open_sound)
			play(open_sound,src)

		door_state = DOOR_STATE_START_OPENING
		update_sprite()

		sleep(open_wait_time)

		door_state = DOOR_STATE_OPENING_01
		update_sprite()

		sleep(open_time_01)

		door_state = DOOR_STATE_OPENING_02
		update_sprite()

		sleep(open_time_02)

		door_state = DOOR_STATE_OPENED
		update_sprite()
		opened_time = 0
		start_thinking(src)

		if(force && !unlock)
			lock()



	return TRUE
*/

/*
obj/structure/interactive/door/airlock/close(var/lock = FALSE, var/force = FALSE)

	if(locked && !force)
		return FALSE

	if(door_state != DOOR_STATE_OPENED || door_state == DOOR_STATE_DENY)
		if(lock)
			lock()
		return FALSE

	spawn()

		if(close_sound)
			play(close_sound,src)

		door_state = DOOR_STATE_CLOSING_01
		update_sprite()

		sleep(close_time_01)

		var/found_living = FALSE
		for(var/mob/living/L in loc.contents)
			if(L)
				found_living = TRUE
				break

		if(found_living)
			opened_time = 0
			door_state = DOOR_STATE_OPENING_02
			update_sprite()

			sleep(open_time_02)

			door_state = DOOR_STATE_OPENED
			update_sprite()
			start_thinking(src)

		else
			door_state = DOOR_STATE_CLOSING_02
			update_sprite()

			sleep(close_time_02)

			door_state = DOOR_STATE_CLOSED
			update_sprite()
			stop_thinking(src)
			if(lock)
				lock()
*/