obj/structure/interactive/barricade
	name = "metal barricade"
	icon = 'icons/obj/structure/barricade.dmi'
	icon_state = "metal"

	plane = PLANE_MOB
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

obj/structure/interactive/barricade/New(var/desired_loc)
	. = ..()
	update_icon()
	return .

obj/structure/interactive/barricade/update_icon()

	if(dir == NORTH)
		pixel_y = -10
		density_south = FALSE
	else if(dir == EAST)
		pixel_x = -8
		pixel_y = -2
		density_west = FALSE
	else if(dir == SOUTH)
		pixel_x = 0
		pixel_y = 0
		density_north = FALSE
	else if(dir == WEST)
		pixel_x = 8
		pixel_y = -2
		density_east = FALSE

	overlays.Cut()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/image/above = new/image(icon,"[icon_state]_above")
	above.layer = LAYER_ABOVE_MOB

	var/image/below = new/image(icon,"[icon_state]_below")
	below.layer = LAYER_BELOW_MOB

	icon = ICON_INVISIBLE
	overlays += below
	overlays += above
