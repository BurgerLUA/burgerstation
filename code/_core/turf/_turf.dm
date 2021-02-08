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
	var/density_down  = FALSE
	var/allow_bullet_pass = FALSE

	var/footstep/footstep //The footstep sounds that play.

	var/list/mob/living/old_living //List of mobs that used to be on this turf.

	var/material_id

	var/delay_modifier = 1 //Increase to make it harder to move on this turf. Decrease to make it easier.

	var/world_spawn = FALSE

	var/lightness = 0 //Calculated tile darkness.

	var/list/stored_shuttle_items

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

/turf/proc/is_safe_teleport()
	return !is_space()

/turf/New(loc)

	. = ..()

	if(opacity)
		has_opaque_atom = TRUE

	return .

/turf/Destroy()

	if(old_living)
		old_living.Cut()

	return ..()

/turf/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	caller.face_atom(src)
	return ..()

/turf/change_victim(var/atom/attacker,var/atom/object)

	for(var/atom/movable/v in contents)
		if(ismob(v) && attacker != v)
			var/mob/M = v
			if(M.mouse_opacity == 0)
				continue
			return v
		if(v.health && v.can_be_attacked(attacker))
			return v

	if(old_living)
		for(var/k in old_living)
			var/mob/living/L = k
			if(L.mouse_opacity > 0 && !L.dead && L.move_delay > 0 && attacker != L)
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

	return .

/turf/Exited(var/atom/movable/exiter,var/atom/new_loc)

	if(src.loc && (!new_loc || src.loc != new_loc.loc))
		src.loc.Exited(exiter)

	. = ..()

	if(!exiter.qdeleting && is_living(exiter))
		do_footstep(exiter,FALSE)

	return .

/turf/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return istype(health)

/turf/Enter(var/atom/movable/enterer,var/atom/oldloc)

	if(density && (enterer.collision_flags && src.collision_flags) && (enterer.collision_flags & src.collision_flags))
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


/turf/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	for(var/atom/A in src.contents)
		A.act_explode(owner,source,epicenter,magnitude,desired_loyalty)

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

/turf/proc/can_construct_on(var/mob/caller)
	caller.to_chat(span("warning","You cannot deploy on this turf!"))
	return FALSE