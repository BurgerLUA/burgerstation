var/global/list/all_landmarks = list()


/obj/marker/landmark
	name = "landmark"
	icon_state = "landmark"

/obj/marker/landmark/New(desired_loc)
	all_landmarks += src
	return ..()