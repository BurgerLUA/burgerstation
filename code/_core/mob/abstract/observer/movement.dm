/mob/abstract/observer/Cross(atom/movable/O)
	if(istype(O,/mob/abstract/))
		return TRUE
	return ..()