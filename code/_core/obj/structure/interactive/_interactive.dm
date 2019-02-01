obj/structure/interactive/
	name = "interactive structure"
	desc = "What does it do?"
	mouse_over_pointer = MOUSE_ACTIVE_POINTER


obj/structure/interactive/proc/can_interact(var/atom/caller)
	if(get_dist(src,caller) > 0)
		caller.to_chat("You're too far away!")
		return FALSE

	return TRUE