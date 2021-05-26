/mob/abstract/observer/Cross(atom/movable/O,atom/oldloc)
	if(istype(O,/mob/abstract/))
		return TRUE
	return ..()