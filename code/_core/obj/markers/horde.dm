var/global/list/obj/marker/horde/all_horde_markers = list()

/obj/marker/horde
	name = "horde marker"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "horde"

/obj/marker/horde/New(desired_loc)
	. = ..()
	all_horde_markers += src


/obj/marker/horde/Destroy()
	all_horde_markers -= src
	. = ..()