/obj/hud/inventory/crafting/
	worn_slots = 0
	held_slots = 1
	icon_state = "square_round"

	priority = 1

	max_size = 100
	max_weight = 100

	flags = FLAGS_HUD_SPECIAL | FLAGS_HUD_CRAFTING

	alpha = 0 //Hidden until enabled
	mouse_opacity = 0 //Off until enabled.
	should_draw = FALSE
	drag_to_take = FALSE


//A
/obj/hud/inventory/crafting/slotA1
	name = "A1"
	id = "a1"
	screen_loc = "CENTER-4-1,CENTER+1"

/obj/hud/inventory/crafting/slotA2
	name = "A2"
	id = "a2"
	screen_loc = "CENTER-4,CENTER+1"

/obj/hud/inventory/crafting/slotA3
	name = "A3"
	id = "a3"
	screen_loc = "CENTER-4+1,CENTER+1"

//B
/obj/hud/inventory/crafting/slotB1
	name = "B1"
	id = "b1"
	screen_loc = "CENTER-4-1,CENTER+0"

/obj/hud/inventory/crafting/slotB2
	name = "B2"
	id = "b2"
	screen_loc = "CENTER-4,CENTER+0"

/obj/hud/inventory/crafting/slotB3
	name = "B3"
	id = "b3"
	screen_loc = "CENTER-4+1,CENTER+0"

//C
/obj/hud/inventory/crafting/slotC1
	name = "C1"
	id = "c1"
	screen_loc = "CENTER-4-1,CENTER-1"

/obj/hud/inventory/crafting/slotC2
	name = "C2"
	id = "c2"
	screen_loc = "CENTER-4,CENTER-1"

/obj/hud/inventory/crafting/slotC3
	name = "C3"
	id = "c3"

	screen_loc = "CENTER-4+1,CENTER-1"

/obj/hud/inventory/crafting/result
	screen_loc = "CENTER-4+3,CENTER"
