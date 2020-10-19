obj/structure/interactive/fence
	name = "fence"
	icon = 'icons/obj/structure/fence.dmi'
	icon_state = "straight"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_NONE

	bullet_block_chance = 0

	pixel_y = 14

	health = /health/construction/

	health_base = 100

	density = TRUE

/obj/structure/interactive/fence/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 4),/material/steel)
	. = ..()
	qdel(src)
	return .

obj/structure/interactive/fence/end
	icon_state = "end"

obj/structure/interactive/fence/post
	icon_state = "post"

obj/structure/interactive/fence/corner
	icon_state = "corner"

obj/structure/interactive/fence/door
	icon_state = "door_opened"
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_NONE