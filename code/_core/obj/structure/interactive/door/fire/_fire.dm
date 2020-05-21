/obj/structure/interactive/door/fire
	name = "fire door"
	desc = "Protects you from stupidity."
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	icon = 'icons/obj/structure/airlock/fire.dmi'
	icon_state = "fire"

	opacity = 0
	door_state = DOOR_STATE_OPENED

	alpha = 100

/obj/structure/interactive/door/fire/New(var/desired_loc)
	alpha = 255
	return ..()