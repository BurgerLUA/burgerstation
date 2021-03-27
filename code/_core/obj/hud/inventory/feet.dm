/obj/hud/inventory/organs/left_foot
	name = "left foot slot"
	icon_state = "slot_foot_left"
	id = BODY_FOOT_LEFT
	screen_loc = "LEFT+2,BOTTOM"
	click_flags = LEFT_FOOT

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_LEFT

	max_slots = 3
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 50

/obj/hud/inventory/organs/right_foot
	name = "right foot slot"
	icon_state = "slot_foot_right"
	id = BODY_FOOT_RIGHT
	screen_loc = "LEFT+1,BOTTOM"
	click_flags = RIGHT_FOOT

	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_RIGHT

	max_slots = 3
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 51