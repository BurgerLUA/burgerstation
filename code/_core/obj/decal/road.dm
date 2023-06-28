/obj/decal/road_marking
	name = "road marking"
	plane = PLANE_FLOOR
	layer = LAYER_FLOOR_ROAD_DECAL

/obj/decal/road_marking/dotted_line
	icon_state = "1"
	icon = 'icons/obj/decal/road_dotted.dmi'

/obj/decal/road_marking/dotted_line/half
	icon_state = "1"
	icon = 'icons/obj/decal/road_dotted_half.dmi'

/obj/decal/road_marking/dotted_line/New(var/desired_loc)
	icon_state = "[rand(1,6)]"
	. = ..()

/obj/decal/road_marking/solid_cross
	icon_state = "1"
	icon = 'icons/obj/decal/road_solid_cross.dmi'

/obj/decal/road_marking/solid_cross/New(var/desired_loc)
	icon_state = "[rand(1,3)]"
	. = ..()

/obj/decal/road_marking/solid_stop
	icon_state = "1"
	icon = 'icons/obj/decal/road_solid_stop.dmi'

/obj/decal/road_marking/solid_stop/New(var/desired_loc)
	icon_state = "[rand(1,3)]"
	. = ..()

/obj/decal/road_marking/solid_line
	icon_state = "1"
	icon = 'icons/obj/decal/road_solid.dmi'

/obj/decal/road_marking/solid_line/New(var/desired_loc)
	icon_state = "[rand(1,4)]"
	. = ..()

/obj/decal/road_marking/solid_line/yellow
	color = "#FFD800"

/obj/decal/road_marking/solid_line/offset
	icon = 'icons/obj/decal/road_solid_offset.dmi'

/obj/decal/road_marking/solid_line/offset/yellow
	color = "#FFD800"

/obj/decal/road_marking/hazard
	icon_state = "1"
	icon = 'icons/obj/decal/road_hazard.dmi'

/obj/decal/road_marking/hazard/New(var/desired_loc)
	icon_state = "[rand(1,4)]"
	. = ..()

/obj/decal/road_marking/hazard/yellow
	color = "#FFD800"