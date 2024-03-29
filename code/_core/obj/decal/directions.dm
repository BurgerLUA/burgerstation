/obj/decal/directions/PostInitialize()

	. = ..()

	if(dir == EAST || dir == WEST)
		pixel_x = offset*5*(dir == WEST ? 1 : -1)
		if(y % 5 == 0)
			icon_state = "[initial(icon_state)]_[id]"
	else if(dir == NORTH || dir == SOUTH)
		pixel_y = offset*5*(dir == SOUTH ? 1 : -1)
		if(x % 5 == 0)
			icon_state = "[initial(icon_state)]_[id]"


/obj/decal/directions/security
	id = "sec"
	color = COLOR_NANOTRASEN
	offset = 0

/obj/decal/directions/security/left
	icon_state = "left"


/obj/decal/directions/engineering
	id = "eng"
	color = COLOR_ENGINEERING
	offset = 1

/obj/decal/directions/engineering/left
	icon_state = "left"

/obj/decal/directions/med
	id = "med"
	color = COLOR_MEDICAL
	offset = 2

/obj/decal/directions/med/left
	icon_state = "left"

/obj/decal/directions/science
	id = "sci"
	color = COLOR_SCIENCE
	offset = 3

/obj/decal/directions/science/left
	icon_state = "left"