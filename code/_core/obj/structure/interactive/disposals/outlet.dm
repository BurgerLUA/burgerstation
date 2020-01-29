/obj/structure/interactive/disposals/outlet
	name = "disposals outlet"
	icon_state = "outlet"
	connects_down = TRUE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE

	var/throw_accuracy = 0
	var/throw_velocity = 10
	var/throw_range_min = 1
	var/throw_range_max = 3

	plane = PLANE_OBJ

/obj/structure/interactive/disposals/outlet/on_container_enter(var/obj/disposals_container/C)

	var/list/throw_offset = direction_to_pixel_offset(dir)

	for(var/atom/movable/M in C.contents)

		var/diff_x = throw_offset[1] + rand_precise(-throw_accuracy,throw_accuracy)
		var/diff_y = throw_offset[2] + rand_precise(-throw_accuracy,throw_accuracy)

		var/highest = max(abs(diff_x),abs(diff_y))

		if(highest > 0)
			diff_x = diff_x/highest
			diff_y = diff_y/highest
		else
			diff_x = throw_offset[1]
			diff_y = throw_offset[2]

		var/obj/projectile/bullet/thrown/P = M.throw_self(src,null,null,null,diff_x*throw_velocity,diff_y*throw_velocity)
		P.steps_allowed = rand(throw_range_min,throw_range_max)

	qdel(C)

	return ..()

/obj/structure/interactive/disposals/outlet/random
	throw_accuracy = 0.5
	throw_range_min = 3
	throw_range_max = 7