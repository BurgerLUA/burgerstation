/obj/hud/inventory/organs/torso //Undershirt + Shirt
	name = "torso slot"
	id = BODY_TORSO
	screen_loc = "LEFT+1,BOTTOM+2"
	worn_slots = 2

	item_slot = SLOT_TORSO | SLOT_TORSO_U

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

/obj/hud/inventory/organs/torso/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!..())
		return FALSE

	for(var/obj/item/I2 in worn_objects)
		if(I.item_slot & SLOT_TORSO_U)
			if(messages)
				owner.to_chat(span("notice","You can't wear \the [I] over \the [I2]!"))
			return FALSE
		if(I.item_slot & SLOT_TORSO && I2.item_slot & SLOT_TORSO)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE
		if(I.item_slot & SLOT_TORSO_U && I2.item_slot & SLOT_TORSO_U)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE

	return TRUE

/obj/hud/inventory/organs/torso_o
	name = "coat slot"
	id = BODY_TORSO_O
	screen_loc = "LEFT,BOTTOM+2"
	worn_slots = 2

	item_slot = SLOT_TORSO_O | SLOT_TORSO_A

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

/obj/hud/inventory/organs/torso_o/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!..())
		return FALSE

	for(var/obj/item/I2 in worn_objects)
		if(I.item_slot & SLOT_TORSO_A)
			if(messages)
				owner.to_chat(span("notice","You can't wear \the [I] over \the [I2]!"))
			return FALSE
		if(I.item_slot & SLOT_TORSO_O && I2.item_slot & SLOT_TORSO_O)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE
		if(I.item_slot & SLOT_TORSO_A && I2.item_slot & SLOT_TORSO_A)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE

	return TRUE

/obj/hud/inventory/organs/torso_b
	name = "back slot"
	id = BODY_TORSO_B
	screen_loc = "CENTER-3,BOTTOM"
	worn_slots = 1

	item_slot = SLOT_TORSO_B

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

/obj/hud/inventory/organs/torso_ob
	name = "overwear belt slot"
	id = BODY_TORSO_OB
	screen_loc = "CENTER-4,BOTTOM"
	held_slots = 1

	item_slot = SLOT_TORSO_OB

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB