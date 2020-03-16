/obj/decal/poster/
	name = "poster"
	icon = 'icons/obj/decal/poster.dmi'
	mouse_opacity = 1
	icon_state = null
	plane = PLANE_WALL
	layer = LAYER_WALL_DECAL

/obj/decal/poster/Initialize()
	setup_dir_offsets(src)
	dir = SOUTH
	return ..()

/obj/decal/poster/nanotrasen/Initialize() //Random positive poster.
	. = ..()
	icon_state = "poster[rand(1,35)]_legit"

	world.log << "[icon_state] [dir]."
	return .

/obj/decal/poster/syndicate/Initialize() //Random negative poster.
	. = ..()
	icon_state = "poster[rand(1,44)]"
	return .