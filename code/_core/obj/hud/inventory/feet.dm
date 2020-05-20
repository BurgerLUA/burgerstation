/obj/hud/inventory/organs/left_foot
	name = "left foot slot"
	icon_state = "slot_foot_left"
	id = BODY_FOOT_LEFT
	screen_loc = "LEFT+2,BOTTOM"
	click_flags = LEFT_FOOT
	item_slot = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U | SLOT_FOOT_LEFT_O
	worn_slots = 3

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 65

/obj/hud/inventory/organs/left_foot/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!..())
		return FALSE

	for(var/obj/item/I2 in worn_objects)
		if(I.item_slot & SLOT_FOOT_LEFT_U)
			if(messages)
				owner.to_chat(span("notice","You can't wear \the [I] over \the [I2]!"))
			return FALSE
		if(I.item_slot & SLOT_FOOT_LEFT && I2.item_slot & SLOT_FOOT_LEFT_O)
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
		if(I.item_slot & SLOT_FOOT_LEFT_O && I2.item_slot & SLOT_FOOT_LEFT_O)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE

	return TRUE

/obj/hud/inventory/organs/right_foot
	name = "right foot slot"
	icon_state = "slot_foot_right"
	id = BODY_FOOT_RIGHT
	screen_loc = "LEFT+1,BOTTOM"
	click_flags = RIGHT_FOOT
	item_slot = SLOT_FOOT_RIGHT | SLOT_FOOT_RIGHT_U | SLOT_FOOT_RIGHT_O
	worn_slots = 3

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 66

/obj/hud/inventory/organs/right_foot/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!..())
		return FALSE

	for(var/obj/item/I2 in worn_objects)
		if(I.item_slot & SLOT_FOOT_RIGHT_U)
			if(messages)
				owner.to_chat(span("notice","You can't wear \the [I] over \the [I2]!"))
			return FALSE
		if(I.item_slot & SLOT_FOOT_RIGHT && I2.item_slot & SLOT_FOOT_RIGHT_O)
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
		if(I.item_slot & SLOT_FOOT_RIGHT_O && I2.item_slot & SLOT_FOOT_RIGHT_O)
			if(messages)
				owner.to_chat(span("notice","You are already wearing clothing of this type!"))
			return FALSE

	return TRUE