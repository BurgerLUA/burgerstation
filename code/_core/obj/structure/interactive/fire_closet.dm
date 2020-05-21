/obj/structure/interactive/fire_closet
	name = "fire closet"
	icon = 'icons/obj/structure/fire_closet.dmi'
	icon_state = "extinguisher"

	plane = PLANE_WALL_ATTACHMENTS

/obj/structure/interactive/fire_closet/Initialize()
	setup_dir_offsets()
	dir = SOUTH
	icon_state = "[initial(icon_state)]_closed"
	return ..()