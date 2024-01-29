var/global/list/turf/ghost_markers = list()

/obj/marker/ghost
	name = "ghost marker"

/obj/marker/ghost/New(desired_loc)
	ghost_markers += loc
	return ..()

/obj/marker/ghost/Finalize()
	. = ..()
	qdel(src)
	