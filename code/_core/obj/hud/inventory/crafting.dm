/obj/hud/inventory/crafting/
	max_slots = 1
	icon_state = "square_round"

	max_size = SIZE_8

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_SPECIAL | FLAGS_HUD_CRAFTING

	alpha = 0 //Hidden until enabled
	mouse_opacity = 0 //Off until enabled.
	should_draw = FALSE
	drag_to_take = FALSE

	item_blacklist = list(
		/obj/item/crafting/
	)

//A
/obj/hud/inventory/crafting/slotA1
	name = "A1"
	id = "a1"
	screen_loc = "CENTER-1,TOP-3+1"

/obj/hud/inventory/crafting/slotA2
	name = "A2"
	id = "a2"
	screen_loc = "CENTER,TOP-3+1"

/obj/hud/inventory/crafting/slotA3
	name = "A3"
	id = "a3"
	screen_loc = "CENTER+1,TOP-3+1"

//B
/obj/hud/inventory/crafting/slotB1
	name = "B1"
	id = "b1"
	screen_loc = "CENTER-1,TOP-3+0"

/obj/hud/inventory/crafting/slotB2
	name = "B2"
	id = "b2"
	screen_loc = "CENTER,TOP-3+0"

/obj/hud/inventory/crafting/slotB3
	name = "B3"
	id = "b3"
	screen_loc = "CENTER+1,TOP-3+0"

//C
/obj/hud/inventory/crafting/slotC1
	name = "C1"
	id = "c1"
	screen_loc = "CENTER-1,TOP-3-1"

/obj/hud/inventory/crafting/slotC2
	name = "C2"
	id = "c2"
	screen_loc = "CENTER,TOP-3-1"

/obj/hud/inventory/crafting/slotC3
	name = "C3"
	id = "c3"

	screen_loc = "CENTER+1,TOP-3-1"

/obj/hud/inventory/crafting/result
	screen_loc = "CENTER+3,TOP-3"
