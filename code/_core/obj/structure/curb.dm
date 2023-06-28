/obj/structure/sidewalk_curb
	name = "sidewalk curb"
	icon = 'icons/obj/structure/table/curb.dmi'
	icon_state = "base"
	mouse_opacity = 0
	alpha = 255

	density = 0
	anchored = 1

	corner_icons = TRUE
	corner_category = "curb"

	plane = PLANE_ROAD
	layer = LAYER_FLOOR_CARPET

/obj/structure/sidewalk_curb/update_icon()
	. = ..()
	if(smooth_code_1 == "nw" || smooth_code_2 == "ne" || smooth_code_3 == "sw" || smooth_code_4 == "se")
		layer = initial(layer) + 1