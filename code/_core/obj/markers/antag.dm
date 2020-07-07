var/global/list/all_antag_markers = list()


/obj/marker/antag
	name = "antag marker"

/obj/marker/antag/New(var/desired_loc)
	all_antag_markers += src
	return ..()