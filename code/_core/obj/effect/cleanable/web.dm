/obj/effect/cleanable/cobweb
	name = "cobweb"
	icon = 'icons/obj/structure/cobweb.dmi'
	icon_state = "cobweb1"
	enable_chunk_clean = FALSE

	plane = PLANE_SCENERY

/obj/effect/cleanable/cobweb/New(var/desired_loc)
	. = ..()
	icon_state = pick("cobweb1","cobweb2")