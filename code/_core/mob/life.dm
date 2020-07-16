/mob/proc/on_life_client()
	if(!initialized)
		return FALSE
	handle_movement(CLIENT_TICK)
	return TRUE