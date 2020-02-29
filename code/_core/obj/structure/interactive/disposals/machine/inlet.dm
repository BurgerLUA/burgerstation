/obj/structure/interactive/disposals/machine/inlet
	name = "disposals inlet"
	icon_state = "intake"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = FALSE
	density_south = FALSE
	density_east  = FALSE
	density_west  = FALSE

	plane = PLANE_OBJ

/obj/structure/interactive/disposals/machine/inlet/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		density_north = !(dir & NORTH)
		density_east = !(dir & EAST)
		density_south = !(dir & SOUTH)
		density_west = !(dir & WEST)

	return .

/obj/structure/interactive/disposals/machine/inlet/Crossed(var/atom/movable/O)
	enter_pipe(O)
	return ..()