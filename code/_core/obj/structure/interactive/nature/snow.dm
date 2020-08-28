obj/structure/scenery/pinetrees
	name = "pinetree"
	icon = 'icons/obj/structure/flora/pinetrees.dmi'
	icon_state = "pine_1"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	pixel_x = -16
	pixel_y = 0
	layer = LAYER_LARGE_OBJ

	plane = PLANE_SCENERY

	mouse_opacity = 1


obj/structure/scenery/pinetrees/New()
	..()
	icon_state = "pine_[rand(1,3)]"


obj/structure/scenery/snow_grass
	name = "grass"
	icon = 'icons/obj/structure/flora/snowflora.dmi'
	icon_state = "snowgrass1"


obj/structure/scenery/snow_grass/New()
	..()
	icon_state = "snowgrass[rand(1,3)]"


obj/structure/scenery/snow_bush
	name = "berry bush"
	icon = 'icons/obj/structure/flora/snowflora.dmi'
	icon_state = "snowbush1"
	layer = LAYER_LARGE_OBJ


obj/structure/scenery/snow_bush/New()
	..()
	icon_state = "snowbush[rand(1,3)]"



/obj/structure/interactive/pine_tree
	name = "dead tree"
	icon = 'icons/obj/structure/flora/pinetrees.dmi'
	icon_state = "pine_2"

	layer = LAYER_LARGE_OBJ
	plane = PLANE_SCENERY

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	health = /health/construction/
	health_base = 250

	pixel_x = -16

	mouse_opacity = 1

/obj/structure/interactive/pine_tree/on_destruction(var/mob/caller,var/damage = FALSE)
	. = ..()
	QDEL_NULL(health)
	icon_state = "pine_stump"
	collision_flags = FLAG_COLLISION_CRAWLING
	collision_bullet_flags = FLAG_COLLISION_SPECIFIC
	return .

/obj/structure/interactive/pine_tree/New(var/desired_loc)
	icon_state = "pine_[rand(1,3)]"
	return ..()

/obj/structure/interactive/pine_tree/can_be_attacked()
	return TRUE