var/global/list/mission_mob_markers = list()

/obj/marker/mission_mob
	name = "mission mob marker"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "mission_spawn"


/obj/marker/mission_mob/New(var/desired_loc)
	. = ..()
	mission_mob_markers += src


/obj/marker/mission_mob/Destroy()
	. = ..()
	mission_mob_markers -= src