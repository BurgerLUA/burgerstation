/obj/decal/
	name = "decal"
	plane = PLANE_FLOOR
	mouse_opacity = 0
	anchored = TRUE
	plane = PLANE_FLOOR
	layer = LAYER_FLOOR_DECAL

	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID

/*
/obj/decal/Initialize()
	try_attach_to()
	. = ..()
*/

/obj/decal/directions
	icon = 'icons/obj/decal/station_markers.dmi'
	icon_state = "right"
	alpha = 200
	var/id = "null"
	var/offset = 0