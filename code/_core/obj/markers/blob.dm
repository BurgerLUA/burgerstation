var/global/list/possible_blob_locations = list()

/obj/marker/blob //For the zombie gamemode.
	name = "possible blob location"

/obj/marker/blob/New(var/desired_loc)
	. = ..()
	possible_blob_locations += src
