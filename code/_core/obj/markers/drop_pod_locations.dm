var/global/list/drop_pod_locations = list()

/obj/marker/drop_pod_location
	name = "drop pod location"
	icon_state = "pod"

/obj/marker/drop_pod_location/New(desired_loc)
	drop_pod_locations += get_turf(src)
	return ..()