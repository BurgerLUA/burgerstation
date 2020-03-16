/obj/projectile/bullet/thrown/
	name = "thrown object"
	id = "thrown"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	hit_target_turf = TRUE

	impact_effect_turf = null
	impact_effect_movable = null

/obj/projectile/bullet/thrown/post_on_hit(var/atom/hit_atom)

	. = ..()

	for(var/atom/movable/A in src.contents)
		A.set_dir(dir)
		A.force_move(previous_loc)
		var/did_move = A.Move(current_loc ? current_loc : previous_loc,silent=TRUE)
		if(is_living(A))
			var/mob/living/L = A
			var/steps = max(1,steps_allowed)
			var/guessed_velocity = clamp(10*steps*(1 - steps_current/steps),10,40)
			if(did_move)
				guessed_velocity *= 0.5
			if(!L.dead)
				L.add_stun(10 + guessed_velocity)

	return .

/*Old
/obj/projectile/bullet/thrown/post_on_hit(var/atom/hit_atom)

	. =..()

	for(var/atom/movable/A in src.contents)
		A.set_dir(dir)
		if(!is_floor(hit_atom))
			A.force_move(previous_loc)
			A.pixel_x = vel_x
			A.pixel_y = vel_y

			var/steps = max(1,steps_allowed)

			animate(A,pixel_x = 0, pixel_y = 0, time = 10 * (1/steps) )
			if(is_living(A))
				var/mob/living/L = A
				var/guessed_velocity = clamp(10*steps*(1 - steps_current/steps),10,40)
				if(!L.dead)
					L.add_stun(10 + guessed_velocity)
		else
			A.force_move(get_turf(hit_atom))
			if(is_living(A))
				var/mob/living/L = A
				if(!L.dead)
					L.add_stun(10)


	return .
*/