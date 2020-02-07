var/global/list/obj/marker/horde/invasion/all_horde_invasion_markers = list()
var/global/list/obj/marker/horde/invasion/all_horde_patrol_markers = list()





/obj/marker/horde
	name = "horde marker"



/obj/marker/horde/invasion/New(var/desired_loc)
	all_horde_invasion_markers += src
	return ..()


/obj/marker/horde/patrol/New(var/desired_loc)
	all_horde_patrol_markers += src
	return ..()

