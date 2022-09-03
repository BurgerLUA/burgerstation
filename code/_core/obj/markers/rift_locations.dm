var/global/list/bluepace_rift_markers = list()

/obj/marker/bluepace_rift_location
	name = "rift location"

/obj/marker/bluepace_rift_location/New(var/desired_loc)
	. = ..()
	bluepace_rift_markers += src

var/global/list/wizard_rift_markers = list()

/obj/marker/wizard_rift_location
	name = "wizard rift location"

/obj/marker/wizard_rift_location/New(var/desired_loc)
	. = ..()
	wizard_rift_markers += src
