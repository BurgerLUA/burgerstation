/obj/decal/poster/
	name = "poster"
	icon = 'icons/obj/decal/poster.dmi'
	mouse_opacity = 1
	icon_state = null
	plane = PLANE_WALL
	layer = LAYER_WALL_DECAL

/obj/decal/poster/New(var/desired_loc)
	setup_dir_offsets(src)
	dir = SOUTH
	return ..(loc)

/obj/decal/poster/nanotrasen/New(var/desired_loc) //Random positive poster.
	. = ..()
	icon_state = "poster[rand(1,35)]_legit"
	return .

/obj/decal/poster/syndicate/New(var/desired_loc) //Random negative poster.
	. = ..()
	icon_state = "poster[rand(1,44)]"
	return .