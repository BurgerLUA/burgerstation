var/global/list/teleport_locations = list()

/obj/marker/teleport_location
	name = "teleport location"
	id = null

/obj/marker/teleport_location/New()
	..()
	if(id)
		teleport_locations[id] = src

/obj/marker/teleport_location/ship_exit
	name = "ship exit"
	id = "ship_exit"


/obj/marker/teleport_location/clockwork_exit
	name = "clockwork exit"
	id = "clockwork_exit"