obj/structure/interactive/
	name = "interactive structure"
	desc = "What does it do?"
	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	var/interact_distance = 1


obj/structure/interactive/proc/can_interact(var/atom/caller)
	if(get_dist(src,caller) > interact_distance)
		caller.to_chat("You're too far away!")
		return FALSE

	return TRUE