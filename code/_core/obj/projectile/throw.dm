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

	return .




