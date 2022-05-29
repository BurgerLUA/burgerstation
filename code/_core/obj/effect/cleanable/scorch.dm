/obj/effect/cleanable/scorch
	name = "scorch mark"
	icon = 'icons/obj/effects/scorch.dmi'
	icon_state = "rust1"
	enable_chunk_clean = FALSE

	plane = FLOAT_PLANE
	layer = FLOAT_LAYER

/obj/effect/cleanable/scorch/New(var/desired_loc)
	icon_state = "[rand(1,6)]"
	. = ..()