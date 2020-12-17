/obj/structure/interactive/shield
	name = "shield"
	desc = "Science!"
	desc = "A special shield wall that miraculously blocks people and air from escaping the shuttle, but allows for marked ships and shuttles to pass."
	icon = 'icons/obj/structure/shield_gen.dmi'
	icon_state = "shieldwall"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	collision_dir = NORTH | EAST | SOUTH | WEST

	plane = PLANE_WALL

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#0000FF"
