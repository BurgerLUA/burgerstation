/turf/simulated/floor/
	name = "FLOOR"
	density_down = TRUE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/footstep_id = "default"

/turf/simulated/floor/is_safe_teleport()
	if(collision_flags & FLAG_COLLISION_WALKING)
		return FALSE

	return TRUE

/turf/simulated/floor/Exited(var/atom/movable/exiter, var/atom/new_loc)

	. = ..()

	if(footstep_id && all_footsteps[footstep_id])
		var/footstep/F = all_footsteps[footstep_id]
		F.on_step(src,exiter,TRUE)

	return .

/turf/simulated/floor/Entered(var/atom/movable/enterer,var/atom/old_loc)

	. = ..()

	if(footstep_id && all_footsteps[footstep_id])
		var/footstep/F = all_footsteps[footstep_id]
		F.on_step(src,enterer,FALSE)

	return .

