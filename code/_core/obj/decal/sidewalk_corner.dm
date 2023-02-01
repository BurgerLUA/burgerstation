/obj/decal/sidewalk_corner //Don't use this. Ugly af.
	name = "sidewalk corner"
	icon = 'icons/turf/floor/sidewalk.dmi'
	icon_state = "corner"
	mouse_opacity = 0
	alpha = 255

/obj/decal/sidewalk_curb
	name = "sidewalk curb"
	icon = 'icons/obj/decal/curb.dmi'
	icon_state = "curb"
	mouse_opacity = 0
	alpha = 255

	plane = PLANE_FLOOR
	layer = LAYER_FLOOR_DECAL + 10

/obj/decal/sidewalk_curb/corner
	icon_state = "curb_corner"

/obj/decal/sidewalk_curb/Generate()
	. = ..()
	icon_state = "[initial(icon_state)]_[rand(1,4)]"