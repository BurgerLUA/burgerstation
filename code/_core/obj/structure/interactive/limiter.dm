/obj/structure/interactive/limiter/
	name = "conveyor limiter"
	desc = "Pssssh."
	desc_extended = "A special device that limits the amount of items that can be on a conveyor space to one."
	icon = 'icons/obj/structure/conveyor.dmi'
	icon_state = "limiter"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density_north = FALSE
	density_south = FALSE
	density_east  = FALSE
	density_west  = FALSE


/obj/structure/interactive/limiter/Initialize()

	if(.)
		density_north = (dir & NORTH)
		density_east = (dir & EAST)
		density_south = (dir & SOUTH)
		density_west = (dir & WEST)

	return ..()