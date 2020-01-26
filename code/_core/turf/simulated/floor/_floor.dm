/turf/simulated/floor/
	name = "FLOOR"
	density_down = TRUE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

/turf/simulated/floor/is_safe_teleport()
	if(collision_flags & FLAG_COLLISION_WALKING)
		return FALSE

	return TRUE