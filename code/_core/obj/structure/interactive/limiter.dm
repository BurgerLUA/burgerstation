/obj/structure/interactive/limiter/
	name = "conveyor limiter"
	desc = "Pssssh."
	desc_extended = "A special device that limits the amount of items that can be on a conveyor space to one."
	icon = 'icons/obj/structure/conveyor.dmi'
	icon_state = "limiter"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	collision_dir = 0x0

/obj/structure/interactive/limiter/Initialize()

	if(.)
		collision_dir = dir

	return ..()