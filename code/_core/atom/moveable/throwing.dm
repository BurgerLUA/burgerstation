/atom/movable/proc/throw_self(var/atom/thrower,var/atom/desired_target,var/target_x,var/target_y,var/vel_x,var/vel_y,var/lifetime = -1, var/steps_allowed = 0,var/desired_iff)

	if(!thrower)
		CRASH_SAFE("No thrower exists!")
		return FALSE

	if(!throwable || anchored)
		if(ismob(thrower))
			var/mob/M = thrower
			M.to_chat(span("warning","You cannot throw \the [src.name]!"))
		return FALSE
	if(istype(src.loc,/obj/projectile/thrown/))
		return FALSE
	var/damage_type_to_use = damage_type_thrown ? damage_type_thrown : damage_type
	var/obj/projectile/thrown/P = new(get_turf(src),thrower,src,vel_x,vel_y,target_x,target_y,get_turf(desired_target),damage_type_to_use,desired_target,"#FFFFFF",thrower,desired_iff = desired_iff)
	P.appearance = src.appearance
	P.pixel_x = src.pixel_x
	P.pixel_y = src.pixel_y
	//P.pixel_x_float = src.pixel_x
	//P.pixel_y_float = src.pixel_y
	P.lifetime = lifetime == -1 ? (max(abs(vel_x),abs(vel_y))/TILE_SIZE)*6 : lifetime
	P.steps_allowed = steps_allowed
	P.mouse_opacity = 0
	INITIALIZE(P)
	FINALIZE(P)
	src.force_move(P) //Move it to contents.
	return P

/atom/movable/proc/on_thrown(var/atom/owner,var/atom/hit_atom,var/atom/hit_wall) //What happens after the person is thrown and it hits an object.
	return TRUE