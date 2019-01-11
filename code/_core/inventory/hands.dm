/obj/inventory/organs/left_hand_worn
	name = "left hand slot"
	id = BODY_HAND_LEFT
	screen_loc = "CENTER+0.5+1,BOTTOM"
	item_slot = SLOT_HAND_LEFT
	worn_slots = 1

/obj/inventory/organs/right_hand_worn
	name = "right hand slot"
	id = BODY_HAND_RIGHT
	screen_loc = "CENTER-0.5-1,BOTTOM"
	item_slot = SLOT_HAND_RIGHT
	worn_slots = 1

/obj/inventory/organs/left_hand_held
	name = "left hand slot"
	id = BODY_HAND_LEFT
	icon_state = "left_hand"
	screen_loc = "CENTER+0.5,BOTTOM"
	click_flags = LEFT_HAND
	item_slot = SLOT_HAND_LEFT
	held_slots = 1
	priority = 100

/obj/inventory/organs/right_hand_held
	name = "right hand slot"
	id = BODY_HAND_RIGHT
	icon_state = "right_hand"
	screen_loc = "CENTER-0.5,BOTTOM"
	click_flags = RIGHT_HAND
	item_slot = SLOT_HAND_RIGHT
	held_slots = 1
	priority = 100