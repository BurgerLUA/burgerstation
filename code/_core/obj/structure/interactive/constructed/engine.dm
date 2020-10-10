obj/structure/shuttle_engine //TODO: RENAME THIS
	name = "engine"
	icon = 'icons/obj/structure/shuttle.dmi'
	icon_state = "router"
	plane = PLANE_SHUTTLE

	collision_flags = FLAG_COLLISION_WALL

	density = TRUE

obj/structure/shuttle_engine/heater
	name = "engine heater"
	icon_state = "heater"

obj/structure/shuttle_engine/burst
	icon_state = "burst_s"

obj/structure/shuttle_engine/burst/left
	icon_state = "burst_l"

obj/structure/shuttle_engine/burst/right
	icon_state = "burst_r"

obj/structure/shuttle_engine/propulsion
	icon_state = "propulsion"

obj/structure/shuttle_engine/propulsion/left
	icon_state = "propulsion_l"

obj/structure/shuttle_engine/propulsion/right
	icon_state = "propulsion_r"

obj/structure/shuttle_engine/wall_diagonal_1
	icon_state = "wall_diagonal_1"
	corner_category = "shuttle"

obj/structure/shuttle_engine/wall_diagonal_2
	icon_state = "wall_diagonal_2"
	corner_category = "shuttle"


obj/structure/shuttle_engine/large
	icon = 'icons/obj/structure/2x2_engine.dmi'
	icon_state = "large_engine"

obj/structure/shuttle_engine/huge
	icon = 'icons/obj/structure/3x3_engine.dmi'
	icon_state = "huge_engine"