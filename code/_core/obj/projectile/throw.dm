/obj/projectile/bullet/thrown/
	name = "thrown object"
	id = "thrown"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	hit_target_turf = TRUE

/obj/projectile/bullet/thrown/post_on_hit(var/atom/hit_atom)

	. =..()

	for(var/atom/movable/A in src.contents)
		if(hit_atom == target_turf && is_floor(target_turf))
			A.force_move(target_turf)
		else
			A.force_move(previous_loc)
			A.pixel_x = vel_x
			A.pixel_y = vel_y
			animate(A,pixel_x = 0, pixel_y = 0, time = SECONDS_TO_DECISECONDS(1))
			if(is_living(A))
				var/mob/living/L = A
				var/guessed_velocity = Clamp(10*steps_allowed*(1 - steps_current/steps_allowed),10,40)
				L.add_stun(guessed_velocity)
				L.add_paralyze(guessed_velocity*0.5)
				L.adjust_brute_loss(guessed_velocity)


	return .




