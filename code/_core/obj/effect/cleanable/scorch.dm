/obj/effect/cleanable/scorch
	name = "scorch mark"
	icon = 'icons/obj/effects/scorch.dmi'
	icon_state = "6"
	enable_chunk_clean = FALSE
	enable_chunk_handling = FALSE

	plane = PLANE_FLOOR_ATTACHMENT
	layer = LAYER_FLOOR_PLATING

/obj/effect/cleanable/scorch/New(desired_loc)
	icon_state = "[rand(1,6)]"
	. = ..()