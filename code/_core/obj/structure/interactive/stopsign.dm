obj/structure/interactive/stopsign
	name = "stop sign"
	desc = "Stop."
	icon = 'icons/obj/structure/stop.dmi'
	icon_state = "sign"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_NONE

	bullet_block_chance = 0

	pixel_z = 8

	density = FALSE

obj/structure/interactive/stopsign/Finalize()
	. = ..()
	update_sprite()


obj/structure/interactive/stopsign/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"grime")
	I.blend_mode = BLEND_INSET_OVERLAY
	I.alpha = rand(4,20)
	add_overlay(I)