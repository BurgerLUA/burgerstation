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






var/global/list/rogue_crewmember_markers = list()

/obj/marker/rogue_crewmember_marker
	name = "rogue crewmember marker"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "syndie"


/obj/marker/rogue_crewmember_marker/New(var/desired_loc)
	. = ..()
	rogue_crewmember_markers += src


/obj/marker/rogue_crewmember_marker/Destroy()
	. = ..()
	rogue_crewmember_markers -= src