/mob/abstract/observer/Cross(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(istype(O,/mob/abstract/))
		return TRUE
	return ..()