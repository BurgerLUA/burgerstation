var/global/list/observer_spawnpoints = list()
var/global/list/spawnpoints_new_character = list()
var/global/list/world_spawnpoints = list()
var/global/list/mob_spawnpoints = list()
var/global/list/chargen_spawnpoints = list()
var/global/list/horde_spawnpoints = list()

/obj/marker/spawnpoint
	name = "GENERATEPOINT"

/obj/marker/spawnpoint/ghost
	name = "ghost spawnpoint"
	desc = "This is where ghosts spawn."

/obj/marker/spawnpoint/ghost/New()
	observer_spawnpoints += get_turf(src)

/obj/marker/spawnpoint/new_character
	name = "new player spawnpoint"
	desc = "This is where new players spawn."

/obj/marker/spawnpoint/chargen
	name = "chargen spawnpoint"
	desc = "This is where new chargen players spawn."

/obj/marker/spawnpoint/chargen/New()
	chargen_spawnpoints += get_turf(src)

/obj/marker/spawnpoint/new_character/New()
	spawnpoints_new_character += get_turf(src)

/obj/marker/spawnpoint/world_point
	name = "world point"
	desc = "This is where you enter the world."

/obj/marker/spawnpoint/world_point/New()
	world_spawnpoints += get_turf(src)

/obj/marker/spawnpoint/horde
	name = "horde mob spawnpoint"
	desc = "This is where horde mobs spawn."

/obj/marker/spawnpoint/horde/New()
	horde_spawnpoints += get_turf(src)