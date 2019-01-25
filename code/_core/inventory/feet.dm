/obj/inventory/organs/left_foot
	name = "left foot slot"
	id = BODY_FOOT_LEFT
	screen_loc = "LEFT+2,BOTTOM"
	click_flags = LEFT_FOOT
	item_slot = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U
	worn_slots = 2

/obj/inventory/organs/left_foot/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!..())
		return FALSE

	for(var/obj/item/I2 in worn_objects)
		if(I.item_slot & SLOT_FOOT_LEFT_U)
			if(messages)
				owner.to_chat(span("notice","You can't wear \the [I] over \the [I2]!"))
			return FALSE
		if(I.item_slot & SLOT_FOOT_LEFT_U && I2.item_slot & SLOT_FOOT_LEFT_U)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE
		if(I.item_slot & SLOT_FOOT_LEFT && I2.item_slot & SLOT_FOOT_LEFT)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE

	return TRUE

/obj/inventory/organs/right_foot
	name = "right foot slot"
	id = BODY_FOOT_RIGHT
	screen_loc = "LEFT+1,BOTTOM"
	click_flags = RIGHT_FOOT
	item_slot = SLOT_FOOT_RIGHT | SLOT_FOOT_RIGHT_U
	worn_slots = 2

/obj/inventory/organs/right_foot/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!..())
		return FALSE

	for(var/obj/item/I2 in worn_objects)
		if(I.item_slot & SLOT_FOOT_RIGHT_U)
			if(messages)
				owner.to_chat(span("notice","You can't wear \the [I] over \the [I2]!"))
			return FALSE
		if(I.item_slot & SLOT_FOOT_RIGHT_U && I2.item_slot & SLOT_FOOT_RIGHT_U)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE
		if(I.item_slot & SLOT_FOOT_RIGHT && I2.item_slot & SLOT_FOOT_RIGHT)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE

	return TRUE