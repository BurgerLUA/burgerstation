var/global/list/shuttle_markers = list()

/obj/marker/shuttle
	name = "shuttle transit position"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "shuttle"

/obj/marker/shuttle/New(var/desired_loc)
	. = ..()
	shuttle_markers[src.type] = src

/obj/marker/shuttle/station/
	name = "station shuttle position"

/obj/marker/shuttle/station/transit
	name = "transit position"

/obj/marker/shuttle/station/destination
	name = "station shuttle position"
