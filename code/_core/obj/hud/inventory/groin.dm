/obj/hud/inventory/organs/groin_o
	name = "belt slot"
	icon_state = "slot_groin_o"
	id = BODY_GROIN_O
	screen_loc = "CENTER-3,BOTTOM:10"

	max_slots = 1
	worn = TRUE

	item_slot = SLOT_GROIN_BELT


	essential = TRUE

	flags = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	priority = 25

/obj/hud/inventory/organs/groin //Underwear + Pants
	name = "pants slot"
	icon_state = "slot_groin"
	id = BODY_GROIN
	screen_loc = "LEFT:2+1,BOTTOM:13+1"

	max_slots = 2
	worn = TRUE

	item_slot = SLOT_GROIN

	flags = FLAG_HUD_INVENTORY | FLAG_HUD_WORN | FLAG_HUD_MOB

	priority = 40

/*
/obj/hud/inventory/organs/groin_u
	name = "bluespace storage"
	icon_state = "slot_groin_o"
	id = BODY_GROIN_U

	max_slots = 1
	worn = FALSE

	item_slot = SLOT_GROIN_BLUESPACE

	flags = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	priority = 1
*/