var/global/list/shuttle_markers = list()

/obj/marker/shuttle
	name = "shuttle transit position"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "shuttle"
	var/reserved = FALSE
	invisibility = 0
	mouse_opacity = 2
	alpha = 255

/obj/marker/shuttle/New(var/desired_loc)
	. = ..()
	shuttle_markers += src