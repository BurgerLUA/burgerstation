var/global/list/observer_spawnpoints = list()
var/global/list/spawnpoints_new_character = list()
var/global/list/world_spawnpoints = list()
var/global/list/mob_spawnpoints = list()
var/global/list/chargen_spawnpoints = list()
var/global/list/horde_spawnpoints = list()
var/global/list/free_for_all_spawnpoints = list()
var/global/list/tdm_spawnpoints = list()
var/global/list/vr_lobby_spawnpoints = list()

/obj/marker/spawnpoint
	name = "GENERATEPOINT"

/obj/marker/spawnpoint/ghost
	name = "ghost spawnpoint"
	desc = "This is where ghosts spawn."

/obj/marker/spawnpoint/ghost/New(var/desired_loc)
	observer_spawnpoints += get_turf(src)
	. = ..()

/obj/marker/spawnpoint/chargen
	name = "chargen spawnpoint"
	desc = "This is where new chargen players spawn."

/obj/marker/spawnpoint/chargen/New(var/desired_loc)
	chargen_spawnpoints += get_turf(src)
	. = ..()

/obj/marker/spawnpoint/world_point
	name = "world point"
	desc = "This is where you enter the world (via cryo)."

/obj/marker/spawnpoint/world_point/New(var/desired_loc)
	world_spawnpoints += get_turf(src)

/obj/marker/spawnpoint/horde
	name = "horde mob spawnpoint"
	desc = "This is where horde mobs spawn."

/obj/marker/spawnpoint/horde/New()
	horde_spawnpoints += get_turf(src)


/obj/marker/spawnpoint/vr/
	icon_state = "spawn"


/obj/marker/spawnpoint/vr/free_for_all
	name = "free for all spawnpoint"
	desc = "For the free for all VR gamemode."
	color = "#00FF00"

/obj/marker/spawnpoint/vr/free_for_all/New(var/desired_loc)
	free_for_all_spawnpoints += get_turf(src)
	. = ..()

/obj/marker/spawnpoint/vr/team_deathmatch
	name = "team deathmatch spawnpoint"
	desc = "For the team deathmatch gamemode"
	color = "#0000FF"

/obj/marker/spawnpoint/vr/team_deathmatch/New(var/desired_loc)
	tdm_spawnpoints += get_turf(src)

/obj/marker/spawnpoint/vr/lobby
	name = "lobby spawnpoint"
	desc = "For placing people in the lobby."
	color = "#FF0000"

/obj/marker/spawnpoint/vr/lobby/New(var/desired_loc)
	vr_lobby_spawnpoints += get_turf(src)
	. = ..()