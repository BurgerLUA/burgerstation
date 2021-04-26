/obj/structure/interactive/blocking_crate
	name = "sturdy crate"
	icon = 'icons/obj/structure/crate.dmi'
	icon_state = "1"
	bullet_block_chance = 100
	density = TRUE
	opacity = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

/obj/structure/interactive/blocking_crate/Generate()
	. = ..()
	icon_state = "[rand(1,5)]"