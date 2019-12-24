var/global/list/obj/marker/horde_teleport/all_hoarde_spawnpoints = list()

/obj/marker/horde_teleport
	name = "horde player teleport location"

/obj/marker/horde_teleport/New(var/desired_location)
	all_hoarde_spawnpoints += src
	return ..()