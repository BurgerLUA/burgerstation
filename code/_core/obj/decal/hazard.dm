/obj/decal/hazard/
	name = "hazard stripes"
	icon = 'icons/obj/decal/hazard.dmi'
	icon_state = "line"
	color = "#FFD800"
	alpha = 175

/obj/decal/hazard/corner
	icon_state = "corner"

/obj/decal/hazard/end
	icon_state = "end"

/obj/decal/hazard/box
	icon_state = "box"

/obj/decal/hazard/full
	icon_state = "full"


/obj/decal/hazard/black
	icon = 'icons/obj/decal/hazard_full.dmi'


/obj/decal/hazard/black/corner
	icon_state = "corner"

/obj/decal/hazard/black/end
	icon_state = "end"

/obj/decal/hazard/black/box
	icon_state = "box"

/obj/decal/hazard/black/full
	icon_state = "full"


/obj/decal/shuttle_landing
	name = "shuttle landing marker"
	icon = 'icons/obj/decal/landing.dmi'
	icon_state = "0,0"
	alpha = 200

/obj/decal/shuttle_number
	name = "shuttle number marker"
	icon = 'icons/obj/decal/shuttle_number.dmi'
	icon_state = "0"
	alpha = 200

/obj/decal/shuttle_number/New(var/desired_loc)
	. = ..()
	pixel_x = rand(-1,1)
	pixel_y = rand(-1,1)