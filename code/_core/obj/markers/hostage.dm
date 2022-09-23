var/global/list/possible_hostage_spawns = list()

var/global/list/possible_hostage_rest_markers = list()

/obj/marker/hostage_spawn
	name = "possible hostage spawn"
	icon_state = "hostage"

/obj/marker/hostage_spawn/New(var/desired_loc)
	if(!SSdmm_suite.is_pvp_coord(loc.x,loc.y,loc.z))
		possible_hostage_spawns += src
	return ..()





/obj/marker/hostage_rest
	name = "hostage rest location"

/obj/marker/hostage_rest/New(var/desired_loc)
	possible_hostage_rest_markers += src
	return ..()