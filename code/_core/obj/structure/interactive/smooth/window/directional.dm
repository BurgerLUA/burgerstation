/obj/structure/smooth/window/directional
	name = "window"
	icon = 'icons/obj/structure/directional_window.dmi'
	icon_state = "normal"

	corner_category = null
	corner_icons = FALSE

	anchored = FALSE

	change_dir_on_move = FALSE

/obj/structure/smooth/window/directional/set_dir(var/desired_dir)

	. = ..()

	density_north = FALSE
	density_east = FALSE
	density_south = FALSE
	density_west = FALSE

	switch(dir)
		if(NORTH)
			density_north = TRUE
		if(EAST)
			density_east = TRUE
		if(SOUTH)
			density_south = TRUE
		if(WEST)
			density_west = TRUE

	return .


/obj/structure/smooth/window/directional/reinforced
	name = "reinforced window"
	icon_state = "reinforced"