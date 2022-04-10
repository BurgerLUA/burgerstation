/obj/effect/cleanable/tile_rot
	name = "tile rot"
	icon = 'icons/obj/effects/tile_rot.dmi'
	icon_state = "1"
	enable_chunk_clean = FALSE

	color = "#725E43"
	alpha = 255

	plane = PLANE_FLOOR
	layer = LAYER_FLOOR_DECAL + 1

/obj/effect/cleanable/tile_rot/New(var/desired_location)
	color = rgb(114 + rand(-20,20),94 + rand(-20,20),67 + rand(-20,20))
	alpha = rand(100,255)
	. = ..()