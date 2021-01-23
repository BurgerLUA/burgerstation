/obj/hud/inventory/organs/groin_o
	name = "belt slot"
	icon_state = "slot_groin_o"
	id = BODY_GROIN_O
	screen_loc = "CENTER-2,BOTTOM"

	max_slots = 1
	worn = TRUE

	item_slot = SLOT_GROIN_O

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 25

/obj/hud/inventory/organs/groin //Underwear + Pants
	name = "pants slot"
	icon_state = "slot_groin"
	id = BODY_GROIN
	screen_loc = "LEFT+1,BOTTOM+1"

	max_slots = 2
	worn = TRUE

	item_slot = SLOT_GROIN_U | SLOT_GROIN

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 40