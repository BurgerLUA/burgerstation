/obj/structure/interactive/barrier
	name = "inflateable barrier"
	desc_extended = "A full-tile barrier that blocks most projectiles from all sides. Very strong."
	icon = 'icons/obj/structure/barricade.dmi'
	icon_state = "full_tile"

	plane = PLANE_MOVABLE
	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	density = TRUE

	collision_dir = NORTH | EAST | SOUTH | WEST

	bullet_block_chance = 100

	health = /health/construction/barricade

	health_base = 800

/obj/structure/interactive/barrier/on_destruction(var/damage = TRUE)
	. = ..()
	qdel(src)