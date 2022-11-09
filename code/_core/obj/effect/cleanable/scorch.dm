/obj/effect/cleanable/scorch
	name = "scorch mark"
	icon = 'icons/obj/effects/scorch.dmi'
	icon_state = "6"
	enable_chunk_clean = FALSE

	plane = PLANE_FLOOR_ATTACHMENT
	layer = 9999

/obj/effect/cleanable/scorch/New(var/desired_loc)
	icon_state = "[rand(1,6)]"
	. = ..()