/obj/hud/inventory/organs/groin_o
	name = "belt slot"
	icon_state = "slot_groin_o"
	id = BODY_GROIN_O
	screen_loc = "CENTER-3,BOTTOM:11"

	max_slots = 1
	worn = TRUE

	item_slot = SLOT_GROIN_BELT


	essential = TRUE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	priority = 25

/obj/hud/inventory/organs/groin_o/update_sprite()

	if(owner && owner.client)
		var/client/C = owner.client
		if(C.settings.loaded_data["compact_mode"])
			screen_loc = "LEFT+4:2,BOTTOM:11"
		else
			screen_loc = initial(screen_loc)

	. = ..()

/obj/hud/inventory/organs/groin //Underwear + Pants
	name = "pants slot"
	icon_state = "slot_groin"
	id = BODY_GROIN
	screen_loc = "LEFT:2+1,BOTTOM:13+1"

	max_slots = 2
	worn = TRUE

	item_slot = SLOT_GROIN

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_WORN | FLAG_HUD_MOB

	priority = 40

/*
/obj/hud/inventory/organs/groin_u
	name = "bluespace storage"
	icon_state = "slot_groin_o"
	id = BODY_GROIN_U

	max_slots = 1
	worn = FALSE

	item_slot = SLOT_GROIN_BLUESPACE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	priority = 1
*/