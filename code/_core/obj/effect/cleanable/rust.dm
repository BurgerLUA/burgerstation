/obj/effect/cleanable/rust
	name = "rust"
	icon = 'icons/obj/effects/rust.dmi'
	icon_state = "rust1"
	enable_chunk_clean = FALSE
	enable_chunk_handling = FALSE

	plane = PLANE_FLOOR_ATTACHMENT
	layer = LAYER_FLOOR_PLATING

/obj/effect/cleanable/rust/New(desired_loc)
	icon_state = pick("rust1","rust2","rust3","rust4")
	. = ..()