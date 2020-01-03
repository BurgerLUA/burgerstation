/obj/decal/
	name = "decal"
	plane = PLANE_FLOOR
	mouse_opacity = 0

/obj/decal/directions
	icon = 'icons/obj/decal/station_markers.dmi'
	icon_state = "right"
	alpha = 50
	id = "null"
	var/offset = 0

/obj/decal/directions/Initialize()

	if(dir == EAST || dir == WEST)
		pixel_x = offset*5*(dir == WEST ? 1 : -1)
		if(y % 5 == 0 + offset)
			icon_state = "[initial(icon_state)]_[id]"
	else if(dir == NORTH || dir == SOUTH)
		pixel_y = offset*5*(dir == SOUTH ? 1 : -1)
		if(x % 5 == 0 + offset)
			icon_state = "[initial(icon_state)]_[id]"
	return ..()

/obj/decal/directions/security
	id = "sec"
	color = "#FF0000"
	offset = 0

/obj/decal/directions/security/left
	icon_state = "left"


/obj/decal/directions/engineering
	id = "eng"
	color = "#FFFF00"
	offset = 1

/obj/decal/directions/engineering/left
	icon_state = "left"