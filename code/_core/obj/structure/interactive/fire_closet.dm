/obj/structure/interactive/fire_closet
	name = "fire closet"
	icon = 'icons/obj/structure/fire_closet.dmi'
	icon_state = "extinguisher"

	plane = PLANE_OBJ

/obj/structure/interactive/fire_closet/Initialize()
	setup_dir_offsets()
	dir = SOUTH
	return ..()

/obj/structure/interactive/fire_closet/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/fire_closet/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)]_closed"
	return .