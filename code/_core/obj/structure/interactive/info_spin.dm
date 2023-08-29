obj/structure/interactive/info_spin
	name = "info display"
	desc = "hello how do i switch hands?"
	desc_extended = "A large, holographic sign designating an information desk. Perhaps you could get some help here?"
	icon = 'icons/obj/structure/info_static.dmi'
	icon_state = "info"
	pixel_y = 10

	plane = PLANE_MOVABLE
	layer = LAYER_LARGE_OBJ

	density = TRUE
	anchored = TRUE

	collision_dir = NORTH | EAST | SOUTH | WEST


obj/structure/interactive/info_spin/Finalize()
	. = ..()
	update_sprite()


obj/structure/interactive/info_spin/update_overlays()
	. = ..()
	var/image/I = new/image('icons/obj/structure/info_speen.dmi',"speen")
	I.alpha = 150
	I.pixel_x = -16
	I.pixel_y = 32
	add_overlay(I)