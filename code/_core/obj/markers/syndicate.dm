var/global/list/turf/all_syndicate_spawns = list()


/obj/marker/syndicate
	name = "horde spawn marker"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "syndie"

/obj/marker/syndicate/New(var/desired_loc)
	all_syndicate_spawns += get_turf(src)
	return ..()