/obj/field_generator_wall
	name = "field generator wall"
	mouse_opacity = 0
	opacity = 0
	density = TRUE
	alpha = 175
	pixel_z = 6

	plane = PLANE_PROJECTILE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ENERGY_FIELD

	collision_dir = NORTH | EAST | SOUTH | WEST

	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID