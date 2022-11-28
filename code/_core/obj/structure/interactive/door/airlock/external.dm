obj/structure/interactive/door/airlock/external
	name = "external airlock"
	desc = "A powered airlock."

	icon = 'icons/obj/structure/airlock/airlock_external_new.dmi'
	icon_state = "closed"

	layer = LAYER_WALL
	plane = PLANE_WALL

	filler = null
	panel = FALSE

	fill_color = null

	open_wait_time = 3


	open_time_01 = 8
	open_time_02 = 8

	close_time_01 = 8
	close_time_02 = 8

	open_sound = 'sound/machines/airlock/open.ogg'
	close_sound = 'sound/machines/airlock/close.ogg'
	deny_sound = 'sound/machines/airlock/deny.ogg'

	safeties = FALSE

	health = /health/construction/

	health_base = 1000

	apc_powered = TRUE

	corner_category = "wall"

	color = "#9F2828"

	var/frame_detail_color = "#C59704"

/obj/structure/interactive/door/airlock/external/update_sprite()

	. = ..()

	if(anchored)
		var/image/frame = new/image(icon,"frame_detail")
		frame.appearance_flags = src.appearance_flags | RESET_COLOR
		frame.color = frame_detail_color
		add_underlay(frame)

obj/structure/interactive/door/airlock/external/no_access

	no_access = TRUE