var/global/list/spawnpoints = list()

/obj/marker/spawnpoint
	name = "SPAWNPOINT"
	invisibility = 101

/obj/marker/spawnpoint/debug
	name = "SPAWNPOINT"
	desc = "The debug spawnpoint. All debug rounds will have players spawn on this spawnpoint."
	id = "debug"

/obj/marker/spawnpoint/debug/New()
	spawnpoints += get_turf(src)