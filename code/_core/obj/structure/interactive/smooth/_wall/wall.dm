/obj/structure/smooth/wall
	name = "short wall"
	desc = "A torso high wall. Low enough to see over."
	desc = "Can be used as basic cover."
	icon = 'icons/obj/structure/smooth/wall.dmi'
	icon_state = "wall"

	corner_category = "small_wall"
	corner_icons = TRUE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	plane = PLANE_WALL

	bullet_block_chance = 50

	density = TRUE

/obj/structure/smooth/wall/wood
	name = "short wood wall"
	color = "#4C3323"
	corner_category = "wood_wall"

/obj/structure/smooth/wall/wood/starting
	color = "#60402C"

/obj/structure/smooth/wall/brick
	name = "short stone wall"
	icon = 'icons/obj/structure/smooth/stone.dmi'
	corner_category = "stone_wall"

/obj/structure/smooth/wall/sand
	name = "short sand wall"
	color = "#CC955F"
	corner_category = "sand_wall"