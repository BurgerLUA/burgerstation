/obj/marker/cover_node
	name = "cover node"
	icon = 'icons/obj/markers/cover.dmi'
	icon_state = "both"
	invisibility = 100
	anchored = 1

	pixel_x = -32
	pixel_y = -32

	var/turn_dir = 0
	var/reserved = FALSE //Reserved by an AI.

	alpha = 150

	density = FALSE

/obj/marker/cover_node/left
	icon_state = "left"

	turn_dir = 90

/obj/marker/cover_node/right
	icon_state = "right"

	turn_dir = -90