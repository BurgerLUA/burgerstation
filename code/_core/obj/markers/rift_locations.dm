var/global/list/rift_markers = list()

/obj/marker/rift_location
	name = "rift location"

/obj/marker/rift_location/New()
	..()
	rift_markers += src