/atom/movable/proc/throw_self(var/atom/thrower,var/atom/desired_target,var/target_x,var/target_y,var/vel_x,var/vel_y,var/lifetime = -1, var/steps_allowed = VIEW_RANGE,var/desired_loyalty_tag)

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
	var/damage_type_to_use = damage_type
	if(damage_type_thrown)
		damage_type_to_use = damage_type_thrown

	if(!damage_type_to_use || damage_type_to_use == /damagetype/error)
		damage_type_to_use = /damagetype/melee/club/stunbaton

	var/obj/projectile/thrown/P = new(
		get_turf(src),
		desired_owner = thrower,
		desired_weapon = src,
		desired_vel_x = vel_x,
		desired_vel_y = vel_y,
		desired_shoot_x = target_x,
		desired_shoot_y = target_y,
		desired_turf = get_turf(desired_target),
		desired_damage_type = damage_type_to_use,
		desired_target = desired_target,
		desired_color ="#FFFFFF",
		desired_blamed = thrower,
		desired_damage_multiplier = 1,
		desired_iff_tag = null,
		desired_loyalty_tag = desired_loyalty_tag,
		desired_inaccuracy_modifier = 0,
		desired_penetrations_left = 0
	)
	P.appearance = src.appearance
	P.pixel_x = src.pixel_x
	P.pixel_y = src.pixel_y
	//P.pixel_x_float = src.pixel_x
	//P.pixel_y_float = src.pixel_y
	P.lifetime = lifetime < 0 ? (max(abs(vel_x),abs(vel_y))/TILE_SIZE)*6 : lifetime
	P.steps_allowed = steps_allowed
	P.mouse_opacity = 0
	INITIALIZE(P)
	FINALIZE(P)
	src.force_move(P) //Move it to contents.
	return P

/atom/movable/proc/on_thrown(var/atom/owner,var/atom/hit_atom,var/atom/hit_wall) //What happens after the person is thrown and it hits an object.
	return TRUE
