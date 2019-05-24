/mob/proc/on_life_client()
	handle_movement(1) //1 is the tickrate
	spam_protection_say = max(0,spam_protection_say-TICKS_TO_SECONDS(1))
	return TRUE