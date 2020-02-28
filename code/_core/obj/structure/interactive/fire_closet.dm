/obj/structure/interactive/fire_closet
	name = "fire closet"
	icon = 'icons/obj/structure/fire_closet.dmi'
	icon_state = "extinguisher"

/obj/structure/interactive/fire_closet/New(var/desired_loc)
	setup_dir_offsets()
	icon_state = "[initial(icon_state)]_closed"
	return ..(loc)