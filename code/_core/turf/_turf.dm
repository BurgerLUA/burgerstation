/turf/
	name = "TURF ERROR"
	icon = 'icons/debug/turfs.dmi'
	icon_state = ""

	plane = PLANE_FLOOR
	layer = LAYER_FLOOR

	appearance_flags = TILE_BOUND
	mouse_over_pointer = MOUSE_INACTIVE_POINTER
	collision_flags = FLAG_COLLISION_NONE

	//Density
	var/density_north = FALSE
	var/density_south = FALSE
	var/density_east  = FALSE
	var/density_west  = FALSE
	var/density_up    = FALSE
	var/density_down  = FALSE
	var/allow_bullet_pass = FALSE

	var/list/mob/living/old_living = list() //List of mobs that used to be on this turf.

/*
/turf/Initialize()
	..()
	area = src.loc //TODO: Remove this, and make sure it's safe to remove.
*/

/turf/proc/is_safe_teleport()
	return FALSE

/turf/New(loc)

	if(opacity)
		has_opaque_atom = TRUE
	..()

/turf/destroy()
	old_living = null
	return ..()

/turf/change_victim(var/atom/attacker)
	for(var/v in contents)
		if(is_mob(v) && attacker != v)
			return v
	for(var/mob/living/L in old_living)
		if(L.move_delay > 0 && attacker != L)
			return L

	return src

/turf/Entered(var/atom/enterer)
	src.loc.Entered(enterer)
	..()

/turf/Exited(var/atom/exiter,var/atom/old_loc)

	..()

	if(is_living(exiter))
		var/mob/living/L = exiter
		if(L.old_turf)
			L.old_turf.old_living -= L
		L.old_turf = src
		old_living += L

/turf/can_be_attacked(var/atom/attacker)
	return FALSE

/turf/Enter(var/atom/movable/enterer,var/atom/oldloc)

	if(enterer.collision_flags & src.collision_flags)
		var/enter_direction = get_dir(oldloc,src)

		if((enter_direction & NORTH) && density_north)
			return FALSE

		if((enter_direction & EAST) && density_east)
			return FALSE

		if((enter_direction & SOUTH) && density_south)
			return FALSE

		if((enter_direction & WEST) && density_west)
			return FALSE

	return ..()