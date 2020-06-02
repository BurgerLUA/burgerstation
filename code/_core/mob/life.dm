/mob/proc/on_life_client()
	if(!initialized)
		return FALSE
	handle_movement(1) //1 is the tickrate
	return TRUE