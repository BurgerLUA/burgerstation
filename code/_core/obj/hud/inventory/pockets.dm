/obj/hud/inventory/organs/groin/pocket
	name = "pocket"
	id = "pocket"
	icon_state = "slot_pocket"
	screen_loc = "CENTER,BOTTOM+3"
	worn_slots = 0
	held_slots = 1
	max_size = SIZE_2
	max_
	//should_draw = FALSE
	drag_to_take = FALSE

	essential = TRUE

	item_bypass = list()

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

/obj/hud/inventory/organs/groin/pocket/right
	name = "left lower pocket"
	id = "pocket01"
	screen_loc = "CENTER+2,BOTTOM"

	priority = 11

/obj/hud/inventory/organs/groin/pocket/left
	name = "right lower pocket"
	id = "pocket02"
	screen_loc = "CENTER+3,BOTTOM"

	priority = 10