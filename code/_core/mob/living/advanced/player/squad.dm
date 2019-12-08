/mob/living/advanced/player/proc/set_squad(var/squad/S)

	if(S == current_squad)
		return FALSE

	current_squad = S

	return TRUE



/mob/living/advanced/player/proc/unset_squad()

	if(!current_squad)
		return FALSE

	current_squad = null

	return TRUE

