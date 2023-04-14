/obj/shield_wall
	name = "shield wall"
	icon = 'icons/obj/effects/shield.dmi'
	icon_state = "shield"
	mouse_opacity = 0
	opacity = 0
	density = TRUE

	plane = PLANE_PROJECTILE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ENERGY_FIELD

	collision_dir = NORTH | EAST | SOUTH | WEST