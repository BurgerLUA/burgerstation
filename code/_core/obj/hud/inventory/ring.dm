/obj/hud/inventory/organs/ring
	name = "ring"
	icon = 'icons//hud/hud_tiny.dmi'
	icon_state = "slot_ring"
	screen_loc = "CENTER,CENTER"

	item_slot = SLOT_RING

	max_slots = 1
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 100

	x_offset = -9
	y_offset = -9

/obj/hud/inventory/organs/ring/nw
	screen_loc = "LEFT+2:3,BOTTOM+4:32"
	id = BODY_RING_01

/obj/hud/inventory/organs/ring/ne
	screen_loc = "LEFT+2:19,BOTTOM+4:32"
	id = BODY_RING_02

/obj/hud/inventory/organs/ring/se
	id = BODY_RING_03
	screen_loc = "LEFT+2:19,BOTTOM+4:16"

/obj/hud/inventory/organs/ring/sw
	id = BODY_RING_04
	screen_loc = "LEFT+2:3,BOTTOM+4:16"

