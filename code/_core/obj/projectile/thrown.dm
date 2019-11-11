/obj/projectile/bullet/thrown/
	name = "thrown object"
	id = "thrown"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	hit_target_turf = TRUE

	impact_effect_turf = null
	impact_effect_movable = null

/obj/projectile/bullet/thrown/post_on_hit(var/atom/hit_atom)

	. =..()

	for(var/atom/movable/A in src.contents)
		if(!is_floor(hit_atom))
			A.force_move(previous_loc)
			A.pixel_x = vel_x
			A.pixel_y = vel_y
			animate(A,pixel_x = 0, pixel_y = 0, time = max(1, 10 * steps_allowed ? (1/steps_allowed) : 10 ))
			if(is_living(A))
				var/mob/living/L = A
				var/guessed_velocity = Clamp(10*steps_allowed*(1 - steps_current/steps_allowed),10,40)
				L.add_stun(guessed_velocity)
				L.add_paralyze(guessed_velocity*0.5)
				//HEALTH TODO: APPLY DAMAGE
		else
			A.force_move(hit_atom)


	return .