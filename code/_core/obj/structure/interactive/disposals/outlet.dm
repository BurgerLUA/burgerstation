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

	var/throw_range = 3

	plane = PLANE_OBJ

/obj/structure/interactive/disposals/outlet/on_container_enter(var/obj/disposals_container/C)

	var/list/throw_offset = direction_to_pixel_offset(dir)

	for(var/atom/movable/M in C.contents)
		var/obj/projectile/bullet/thrown/P = M.throw_self(src,null,null,null,throw_offset[1]*10,throw_offset[2]*10)
		P.steps_allowed = throw_range


	qdel(C)

	return ..()