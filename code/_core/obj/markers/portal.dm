var/global/list/obj/marker/portal/portal_markers = list()

/obj/marker/portal
	name = "portal marker"

/obj/marker/portal/New(var/desired_loc)
	portal_markers |= src
	. = ..()
