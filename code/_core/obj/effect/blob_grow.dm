/obj/effect/blob_grow/
	name = "footprints"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "lightning_01"
	mouse_opacity = 1

	layer = LAYER_EFFECT
	plane = PLANE_EFFECT

	var/tolerance = 1 //Increases every movement.

/obj/effect/blob_grow/post_move(var/atom/old_loc)
	tolerance += 0.1
	. = ..()