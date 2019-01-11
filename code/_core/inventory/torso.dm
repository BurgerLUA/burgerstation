/obj/inventory/organs/torso //Undershirt + Shirt
	name = "torso slot"
	id = BODY_TORSO
	screen_loc = "LEFT+1,BOTTOM+1"
	worn_slots = 2

	item_slot = SLOT_TORSO | SLOT_TORSO_U

/obj/inventory/organs/torso/can_wear_object(var/obj/item/I,var/messages = FALSE)

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

/obj/inventory/organs/torso_o
	name = "coat slot"
	id = BODY_TORSO_O
	screen_loc = "LEFT,BOTTOM+1"
	worn_slots = 2

	item_slot = SLOT_TORSO_O | SLOT_TORSO_A

/obj/inventory/organs/torso_o/can_wear_object(var/obj/item/I,var/messages = FALSE)

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

/obj/inventory/organs/torso_b
	name = "back slot"
	id = BODY_TORSO_B
	screen_loc = "CENTER-0.5-3,BOTTOM"
	worn_slots = 1

	item_slot = SLOT_TORSO_B