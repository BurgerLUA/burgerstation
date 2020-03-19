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

	var/list/mob/living/old_living //List of mobs that used to be on this turf.

	var/material_id

/turf/proc/is_space()
	return FALSE

/turf/proc/update_edges()

	for(var/direction in DIRECTIONS_ALL)
		var/turf/T = get_step(src,direction)
		if(T && is_simulated(T))
			T.update_icon()

	return TRUE

/turf/proc/is_safe_teleport()
	return FALSE

/turf/New(loc)

	. = ..()

	if(opacity)
		has_opaque_atom = TRUE

	return .

/turf/Destroy()

	if(old_living)
		old_living.Cut()

	return ..()

/turf/change_victim(var/atom/attacker)
	for(var/v in contents)
		if(ismob(v) && attacker != v)
			return v

	if(old_living)
		for(var/mob/living/L in old_living)
			if(L.move_delay > 0 && attacker != L)
				return L

	return src

/turf/Entered(var/atom/enterer,var/atom/old_loc)

	if(src.loc && (!old_loc || src.loc != old_loc.loc))
		src.loc.Entered(enterer)

	..()

/turf/Exited(var/atom/exiter,var/atom/new_loc)

	if(src.loc && (!new_loc || src.loc != new_loc.loc))
		src.loc.Exited(exiter)

	..()

	if(is_living(exiter) && !exiter.qdeleting)
		var/mob/living/L = exiter
		L.old_turf = src
		if(!old_living)
			old_living = list()
		old_living += L

/atom/Exited(var/atom/exiter,var/atom/new_loc)

	if(is_living(exiter))
		var/mob/living/L = exiter
		if(L.old_turf && L.old_turf.old_living)
			L.old_turf.old_living -= L

	..()

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


/turf/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude)

	for(var/atom/A in contents)
		CHECK_TICK
		A.act_explode(owner,source,epicenter,magnitude)

	return ..()


/turf/dropped_on_by_object(var/atom/caller,var/atom/object)

	if(is_structure(object) && get_dist(src,object) <= 1 && get_dist(caller,object) <= 1)
		var/obj/structure/S = object
		S.force_move(src)
		return TRUE

	return ..()