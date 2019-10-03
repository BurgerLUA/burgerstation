obj/structure/interactive/barricade
	name = "metal barricade"
	desc_extended = "Has a 60% chance to block most types of projectiles when a bullet passes it from the outside."
	icon = 'icons/obj/structure/barricade.dmi'
	icon_state = "metal"

	plane = PLANE_MOB
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = FALSE
	density_south = FALSE
	density_east  = FALSE
	density_west  = FALSE

	bullet_block_chance = 60

obj/structure/interactive/barricade/New(var/desired_loc)
	. = ..()
	update_icon()
	return .

obj/structure/interactive/barricade/update_icon()

	if(dir == NORTH)
		pixel_y = -10
		density_north = TRUE
	else if(dir == EAST)
		pixel_x = 0
		pixel_y = -2
		density_east = TRUE
	else if(dir == SOUTH)
		pixel_x = 0
		pixel_y = 0
		density_south = TRUE
	else if(dir == WEST)
		pixel_x = 0
		pixel_y = -2
		density_west = TRUE

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
