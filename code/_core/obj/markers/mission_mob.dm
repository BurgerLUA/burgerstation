var/global/list/mission_mob_markers = list()

/obj/marker/mission_mob
	name = "mission mob marker"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "mission_spawn"


/obj/marker/mission_mob/New(var/desired_loc)
	. = ..()
	mission_mob_markers += src


/obj/marker/mission_mob/PreDestroy()
	mission_mob_markers -= src
	. = ..()







var/global/list/rogue_crewmember_markers = list()

/obj/marker/rogue_crewmember_marker
	name = "rogue crewmember marker"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "syndie"


/obj/marker/rogue_crewmember_marker/New(var/desired_loc)
	. = ..()
	rogue_crewmember_markers += src


/obj/marker/rogue_crewmember_marker/PreDestroy()
	rogue_crewmember_markers -= src
	. = ..()



var/global/list/turf/corpse_markers = list()

/obj/marker/mission_corpse
	name = "mission corpse marker"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "corpse"

/obj/marker/mission_corpse/New(var/desired_loc)
	. = ..()
	corpse_markers += src


/obj/marker/mission_corpse/PreDestroy()
	corpse_markers -= src
	. = ..()
