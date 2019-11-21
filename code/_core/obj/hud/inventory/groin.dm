/obj/hud/inventory/organs/groin_o
	name = "belt slot"
	icon_state = "square_trim"
	id = BODY_GROIN_O
	screen_loc = "CENTER-2,BOTTOM"
	worn_slots = 1

	item_slot = SLOT_GROIN_O

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

/obj/hud/inventory/organs/groin //Underwear + Pants
	name = "pants slot"
	id = BODY_GROIN
	screen_loc = "LEFT+1,BOTTOM+1"
	worn_slots = 2

	item_slot = SLOT_GROIN_U | SLOT_GROIN

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

/obj/hud/inventory/organs/groin/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!..())
		return FALSE

	for(var/obj/item/I2 in worn_objects)
		if(I.item_slot & SLOT_GROIN_U)
			if(messages)
				owner.to_chat(span("notice","You can't wear \the [I] over \the [I2]!"))
			return FALSE
		if(I.item_slot & SLOT_GROIN_U && I2.item_slot & SLOT_GROIN_U)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE
		if(I.item_slot & SLOT_GROIN && I2.item_slot & SLOT_GROIN)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE

	return TRUE