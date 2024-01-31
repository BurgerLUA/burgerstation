var/global/list/all_invasion_markers = list()

/obj/marker/invasion
	name = "invasion marker"

/obj/marker/invasion/New(desired_loc)
	all_invasion_markers += src
	. = ..()
