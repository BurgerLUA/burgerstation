/turf/
	name = "TURF ERROR"
	icon = 'icons/debug/turfs.dmi'
	icon_state = ""

	plane = PLANE_FLOOR
	layer = LAYER_FLOOR

	opacity = 0

	appearance_flags = PIXEL_SCALE | TILE_BOUND

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

	var/list/mob/living/old_living //List of mobs that used to be on this turf.

	var/list/stored_shuttle_items //List of movables

	var/safe_fall = FALSE //Set to true if it's safe to fall on this tile.

	vis_flags = VIS_INHERIT_ID | VIS_INHERIT_PLANE | VIS_INHERIT_LAYER | VIS_UNDERLAY

	var/disallow_generation = FALSE

	//Stored variables for shuttles
	var/area/transit_area
	var/turf/transit_turf

	density = FALSE

	var/has_dense_atom = FALSE

	var/has_hazardous_atom = FALSE

/turf/proc/recalculate_atom_density()

	has_dense_atom = FALSE

	if(density)
		has_dense_atom = "recalculate_atom_density() inherent turf density"
		return TRUE

	for(var/k in src.contents)
		var/atom/movable/M = k
		if(M.abstract)
			continue
		if(M.density)
			has_dense_atom = "recalculate_atom_density() [M.type]"
			break

	return TRUE

/turf/proc/recalculate_atom_hazards()

	has_hazardous_atom = FALSE

	if(hazardous)
		has_hazardous_atom = "recalculate_atom_hazards() inherent turf density"
		return TRUE

	for(var/k in src.contents)
		var/atom/movable/M = k
		if(M.abstract)
			continue
		if(M.hazardous)
			has_hazardous_atom = "recalculate_atom_hazards() [M.type]"
			break

	return TRUE

/turf/proc/pre_change() //When this turf is removed in favor of a new turf.
	return TRUE

/turf/proc/get_crossable_neighbors(var/atom/movable/crosser=null,var/cardinal=TRUE,var/intercardinal=TRUE,var/pathfinding=FALSE)

	. = list()
	if(cardinal)
		for(var/d in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,d)
			if(!T)
				continue
			if(T.density && !T.Enter(null,src))
				continue
			var/can_cross = TRUE
			if(T.has_dense_atom)
				for(var/k in T.contents)
					var/atom/movable/M = k
					if(!M.density)
						continue
					if(pathfinding && M.allow_path)
						continue
					if(M.Cross(crosser,src))
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
			if(!T2) continue

			if(T1.density && !T1.Enter(null,src))
				continue

			if(T2.density && !T2.Enter(null,T1))
				continue

			var/can_cross = TRUE
			if(T1.has_dense_atom)
				for(var/k in T1.contents)
					var/atom/movable/M = k
					if(!M.density)
						continue
					if(pathfinding && M.allow_path)
						continue
					if(M.Cross(crosser,src))
						continue
					can_cross = FALSE
					break
				if(!can_cross)
					continue

			if(T2.has_dense_atom)
				for(var/k in T2.contents)
					var/atom/movable/M = k
					if(!M.density)
						continue
					if(pathfinding && M.allow_path)
						continue
					if(M.Cross(crosser,T1))
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

/turf/proc/is_safe()

	if(has_hazardous_atom)
		return FALSE

	if(SSdmm_suite.is_pvp_coord(x,y,z))
		return FALSE

	var/area/A = loc
	if(A && A.flags_area & FLAG_AREA_NO_LOYALTY)
		return FALSE

	return TRUE

/turf/proc/can_teleport_to(var/check_contents=TRUE)
	var/area/A = loc
	if(A && A.flags_area & FLAG_AREA_NO_TELEPORT)
		return FALSE
	return can_move_to(check_contents)

/turf/proc/can_move_to(var/check_contents=TRUE)
	return !is_space()

/turf/New(loc)

	. = ..()

	if(opacity)
		has_opaque_atom = TRUE

	if(density)
		has_dense_atom = "/turf/New() inherent density"


/turf/PreDestroy()
	CRASH("Tried destroying a turf!")
	return FALSE

/*
/turf/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	caller.face_atom(src)
	return ..()
*/

/turf/get_top_object()
	return src //This should always be the src.

/turf/change_victim(var/atom/attacker)

	if(density && (density_north || density_south || density_east || density_west))
		return src

	var/atom/best_target
	var/best_score = -INFINITY

	for(var/k in contents)
		var/atom/movable/v = k
		if(attacker == v)
			continue
		if(!v.health)
			continue
		if(is_living(v))
			var/mob/living/L = v
			if(L.dead)
				continue
		if(!v.can_be_attacked(attacker))
			continue
		var/score = v.plane*1000 + v.layer
		if(score <= best_score)
			continue
		best_target = v
		best_score = score

	if(old_living)
		for(var/k in old_living)
			var/mob/living/L = k
			if(attacker == L)
				continue
			if(L.dead)
				continue
			if(L.next_move <= 0)
				continue
			if(get_dist(L,src) > 1)
				continue
			if(!L.can_be_attacked(attacker))
				continue
			var/score = (L.plane*1000 + L.layer) - (100*1000)
			if(score <= best_score)
				continue
			best_target = L
			best_score = score

	return best_target ? best_target : src

/turf/Entered(var/atom/movable/enterer,var/atom/old_loc)

	if(src.loc && (!old_loc || src.loc != old_loc.loc))
		src.loc.Entered(enterer)

	. = ..()

	if(!density_down && !(enterer.collision_flags & (FLAG_COLLISION_ETHEREAL | FLAG_COLLISION_FLYING)))
		var/turf/T = locate(x,y,z-1)
		if(T && !T.density_up && enterer.Move(T) && !T.safe_fall)
			enterer.on_fall(src)

	if(enterer.density && !enterer.abstract)
		has_dense_atom = "/turf/Entered() [enterer.type]."

/turf/Exited(var/atom/movable/exiter,var/atom/new_loc)

	if(src.loc && (!new_loc || src.loc != new_loc.loc))
		src.loc.Exited(exiter)

	. = ..()

	if(exiter.density)
		recalculate_atom_density()

	if(exiter.hazardous)
		recalculate_atom_hazards()

/turf/Enter(var/atom/movable/enterer,var/atom/oldloc)

	if(enterer && oldloc && length(contents) > TURF_CONTENT_LIMIT && !ismob(enterer))
		return FALSE

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


/turf/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)

	for(var/k in src.contents)
		var/atom/movable/M = k
		M.act_explode(owner,source,epicenter,magnitude,desired_loyalty_tag)

	. = ..()


/turf/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)

	. = ..()

	for(var/k in src.contents)
		var/atom/movable/M = k
		if(M.act_emp(owner,source,epicenter,magnitude,desired_loyalty_tag))
			. = TRUE

/turf/proc/setup_turf_light(var/sunlight_freq)
	return FALSE

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

/turf/proc/can_construct_on(var/atom/caller,var/obj/structure/structure_to_make = null)
	if(!is_living(caller))
		return FALSE
	var/mob/living/C = caller
	C.to_chat(span("warning","You cannot deploy on this turf!"))
	return FALSE

/turf/proc/is_straight_path_to(var/turf/target_turf,var/check_vision=FALSE,var/check_density=TRUE)

	if(src == target_turf)
		return TRUE

	if(!check_vision && !check_density)
		return FALSE

	if(src.z != target_turf.z)
		return FALSE

	var/limit = get_dist(src,target_turf)
	if(limit >= 64) //Don't want to path forever.
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
			if((check_density && T1.has_dense_atom) || (check_vision && T1.has_opaque_atom))
				var/dir2 = next_direction - dir1
				var/turf/T2 = get_step(T,dir2)
				if((check_density && T2.has_dense_atom) || (check_vision && T2.has_opaque_atom))
					return FALSE
		T = get_step(T,next_direction)
		if(T == target_turf)
			return TRUE
		if((check_density && T.has_dense_atom) || (check_vision && T.has_opaque_atom))
			return FALSE