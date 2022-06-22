/obj/effect/cleanable/rust
	name = "rust"
	icon = 'icons/obj/effects/rust.dmi'
	icon_state = "rust1"
	enable_chunk_clean = FALSE

	plane = PLANE_DECAL
	layer = 0

/obj/effect/cleanable/rust/New(var/desired_loc)
	icon_state = pick("rust1","rust2","rust3","rust4")
	. = ..()