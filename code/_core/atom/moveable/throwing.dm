/atom/movable/proc/throw_self(var/atom/thrower,var/desired_target,var/target_x,var/target_y,var/vel_x,var/vel_y)

	if(!throwable)
		if(ismob(thrower))
			var/mob/M = thrower
			M.to_chat("You cannot throw this.")
		return FALSE
	var/damage_type_to_use = damage_type_thrown ? damage_type_thrown : damage_type
	var/obj/projectile/bullet/thrown/P = new(get_turf(src),src,src,vel_x,vel_y,target_x,target_y,get_turf(desired_target),damage_type_to_use,desired_target,"#FFFFFF",thrower)
	P.appearance = src.appearance
	P.pixel_x = src.pixel_x
	P.pixel_y = src.pixel_y
	P.pixel_x_float = src.pixel_x
	P.pixel_y_float = src.pixel_y
	P.lifetime = (max(abs(vel_x),abs(vel_y))/TILE_SIZE)*5
	INITIALIZE(P)
	src.force_move(P) //Move it to contents.
	return P

/mob/living/throw_self(var/atom/thrower,var/desired_target,var/target_x,var/target_y,var/vel_x,var/vel_y)
	var/obj/projectile/bullet/thrown/P = ..()
	if(P)
		P.set_dir(thrower.dir)
	return P

/mob/living/simple/npc/slime/throw_self(var/atom/thrower,var/desired_target,var/target_x,var/target_y,var/vel_x,var/vel_y)
	var/obj/projectile/bullet/thrown/P = ..()
	if(P)
		P.steps_allowed = 3
	return P