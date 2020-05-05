/obj/parallax
	name = "parallax"
	mouse_opacity = 2
	icon = 'icons/obj/effects/parallax.dmi'
	var/ratio = 1 //For every tile moved, move x pixel in the opposite direction.
	plane = PLANE_SPACE

/obj/parallax/layer1
	icon_state = "layer1"
	layer = 1
	ratio = 0

/obj/parallax/layer2
	icon_state = "layer2"
	layer = 2
	blend_mode = BLEND_ADD
	ratio = 0.25

/obj/parallax/layer3
	icon_state = "layer3"
	layer = 3
	blend_mode = BLEND_ADD
	ratio = 0.5

/obj/parallax/layer4
	icon_state = "layer4"
	layer = 4
	ratio = 1