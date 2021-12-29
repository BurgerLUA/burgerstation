/turf/
	name = "TURF ERROR"
	desc = "Report to Burger#3948 on discord"
	icon = 'icons/debug/turfs.dmi'
	icon_state = ""

	plane = PLANE_FLOOR
	layer = LAYER_FLOOR

	mouse_over_pointer = MOUSE_INACTIVE_POINTER
	collision_flags = FLAG_COLLISION_NONE

	//Density
	var/density_north = FALSE
	var/density_south = FALSE
	var/density_east  = FALSE
	var/density_west  = FALSE
	var/density_up    = FALSE
	var/density_down  = TRUE
	var/allow_bullet_pass = FALSE

	var/footstep/footstep //The footstep sounds that play.

	var/list/mob/living/old_living //List of mobs that used to be on this turf.

	var/material_id

	var/move_delay_modifier = 1 //Increase to make it harder to move on this turf. Decrease to make it easier. Only applies to mobs that touch the floor.

	var/world_spawn = FALSE

	var/lightness = 0 //Calculated tile darkness.

	var/list/stored_shuttle_items

	var/safe_fall = FALSE //Set to true if it's safe to fall on this tile.

	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_LAYER | VIS_INHERIT_ID

	var/disallow_generation = FALSE

	var/friction = TRUE //True or false. Can't really do decimals 0 to 1, yet.


/turf/proc/get_crossable_neighbors(var/atom/movable/crosser=null,var/cardinal=TRUE,var/intercardinal=TRUE)

	. = list()
	if(cardinal)
		for(var/d in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,d)
			if(!T.Enter(null,src))
				continue
			var/can_cross = TRUE
			for(var/k in T.contents)
				var/atom/movable/M = k
				if(!M.density)
					continue
				if(M.allow_path)
					continue
				if(!M.Cross(crosser,src))
					continue
				can_cross = FALSE
				break
			if(!can_cross)
				continue
			. += T

	if(intercardinal)
		for(var/d in DIRECTIONS_INTERCARDINAL)
			var/first_dir = get_true_4dir(d)
			var/second_dir = d & ~first_dir

			var/turf/T1 = get_step(src,first_dir)
			if(!T1) continue

			var/turf/T2 = get_step(T1,second_dir)

			if(!T1.Enter(null,src))
				continue

			if(!T2.Enter(null,T1))
				continue

			var/can_cross = TRUE
			for(var/k in T1.contents)
				var/atom/movable/M = k
				if(!M.density)
					continue
				if(M.allow_path)
					continue
				if(!M.Cross(crosser,src))
					continue
				can_cross = FALSE
				break
			if(!can_cross)
				continue

			for(var/k in T2.contents)
				var/atom/movable/M = k
				if(!M.density)
					continue
				if(M.allow_path)
					continue
				if(!M.Cross(crosser,T1))
					continue
				can_cross = FALSE
				break
			if(!can_cross)
				continue

			. += T2


/turf/proc/on_step()
	return TRUE

/turf/proc/is_space()
	var/area/A = loc
	return istype(A) && A.is_space()

/turf/proc/update_edges()

	for(var/direction in DIRECTIONS_ALL)
		var/turf/T = get_step(src,direction)
		if(T && is_simulated(T))
			T.update_sprite()

	return TRUE

/turf/proc/is_safe_teleport(var/check_contents=TRUE)

	var/area/A = loc
	if(A && A.flags_area & FLAG_AREA_NO_LOYALTY)
		return FALSE

	return !is_space()

/turf/New(loc)

	. = ..()

	if(opacity)
		has_opaque_atom = TRUE


/turf/Destroy()

	if(old_living)
		old_living.Cut()

	return ..()

/*
/turf/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	caller.face_atom(src)
	return ..()
*/

/turf/change_victim(var/atom/attacker,var/atom/object)

	if(density) //Not actually a floor but something more.
		return src

	for(var/k in contents)
		var/atom/movable/v = k
		if(attacker == v)
			continue
		if(!v.health)
			continue
		if(ismob(v))
			var/mob/M = v
			if(M.mouse_opacity == 0)
				continue
		if(!v.can_be_attacked(attacker))
			continue
		return v

	if(old_living)
		for(var/k in old_living)
			var/mob/living/L = k
			if(attacker == L || L.dead || L.mouse_opacity <= 0 || L.move_delay < 0 || get_dist(L,src) > 1)
				continue
			return L

	return src

/turf/proc/do_footstep(var/mob/living/source,var/enter=FALSE)

	if(!source.has_footsteps)
		return FALSE

	var/list/returning_footsteps = source.get_footsteps(footstep ? list(footstep) : list(),enter)
	if(length(returning_footsteps))
		return source.handle_footsteps(src,returning_footsteps,enter)

	return FALSE

/turf/Entered(var/atom/movable/enterer,var/atom/old_loc)

	if(src.loc && (!old_loc || src.loc != old_loc.loc))
		src.loc.Entered(enterer)

	. = ..()

	if(!enterer.qdeleting && is_living(enterer))
		do_footstep(enterer,TRUE)

	if(!density_down)
		var/turf/T = locate(x,y,z-1)
		if(T && !T.density_up && enterer.Move(T) && !T.safe_fall)
			enterer.on_fall(src)

/turf/Exited(var/atom/movable/exiter,var/atom/new_loc)

	if(src.loc && (!new_loc || src.loc != new_loc.loc))
		src.loc.Exited(exiter)

	. = ..()

	if(!exiter.qdeleting && is_living(exiter))
		do_footstep(exiter,FALSE)


/turf/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return istype(health)

/turf/Enter(var/atom/movable/enterer,var/atom/oldloc)

	if(density && (!enterer || (enterer.collision_flags && src.collision_flags) && (enterer.collision_flags & src.collision_flags)))
		if(oldloc)
			var/enter_direction = get_dir(oldloc,src)
			if((enter_direction & NORTH) && density_north)
				return FALSE
			if((enter_direction & EAST) && density_east)
				return FALSE
			if((enter_direction & SOUTH) && density_south)
				return FALSE
			if((enter_direction & WEST) && density_west)
				return FALSE
		else if(density_west || density_east || density_south || density_north)
			return FALSE

	return ..()


/turf/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	for(var/k in src.contents)
		var/atom/movable/M = k
		M.act_explode(owner,source,epicenter,magnitude,desired_loyalty)

	return ..()

/turf/proc/setup_turf_light(var/sunlight_freq=VIEW_RANGE*0.5)
	return FALSE

/turf/should_smooth_with(var/turf/T)
	return (T.corner_category == corner_category) && (T.plane == plane)

/turf/proc/is_occupied(var/plane_min=-INFINITY,var/plane_max=INFINITY,var/check_under_tile=FALSE)

	for(var/atom/movable/A in src.contents)
		if(A.plane < plane_min || A.plane > plane_max)
			continue
		if(istype(A,/obj/effect/temp/construction/))
			return A
		if(is_living(A))
			return A
		if(isobj(A))
			var/obj/O = A
			if(check_under_tile && O.under_tile)
				return O
			if(is_structure(O))
				return O

	return null

/turf/proc/can_construct_on(var/mob/caller,var/obj/structure/structure_to_make)
	caller.to_chat(span("warning","You cannot deploy on this turf!"))
	return FALSE


/turf/Finalize()
	. = ..()
	update_sprite()

/turf/proc/is_clear_path_to(var/turf/target_turf)

	if(!isturf(target_turf) || target_turf.has_opaque_atom || src.z != target_turf.z)
		return FALSE

	if(src == target_turf)
		return target_turf.has_opaque_atom


	var/limit = get_dist(src,target_turf)
	if(limit >= 127) //No.
		return FALSE
	limit *= 2 //Compensates for corners.

	var/list/diag = list(
		"[NORTHEAST]" = TRUE,
		"[SOUTHEAST]" = TRUE,
		"[NORTHWEST]" = TRUE,
		"[SOUTHWEST]" = TRUE
	)

	var/turf/T = src
	while(limit>0)
		limit--
		var/next_direction = get_dir(T,target_turf)
		if(diag["[next_direction]"])
			var/dir1 = get_true_4dir(next_direction)
			var/turf/T1 = get_step(T,dir1)
			if(T1.has_opaque_atom)
				var/dir2 = next_direction - dir1
				var/turf/T2 = get_step(T,dir2)
				if(T2.has_opaque_atom)
					return FALSE

		T = get_step(T,next_direction)
		if(T.has_opaque_atom)
			return FALSE
		if(T == target_turf)
			return TRUE