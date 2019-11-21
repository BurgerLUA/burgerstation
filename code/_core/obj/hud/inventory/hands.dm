//Gloves
/obj/hud/inventory/organs/left_hand_worn
	name = "left glove"
	id = BODY_HAND_LEFT + "_worn"
	screen_loc = "LEFT+2,BOTTOM+1"
	item_slot = SLOT_HAND_LEFT
	worn_slots = 1

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

/obj/hud/inventory/organs/right_hand_worn
	name = "right glove"
	id = BODY_HAND_RIGHT + "_worn"
	screen_loc = "LEFT,BOTTOM+1"
	item_slot = SLOT_HAND_RIGHT
	worn_slots = 1

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

//Holding
/obj/hud/inventory/organs/left_hand_held
	name = "left hand slot"
	id = BODY_HAND_LEFT
	icon_state = "left_hand"
	screen_loc = "CENTER+0.5,BOTTOM"
	click_flags = LEFT_HAND
	item_slot = SLOT_HAND_LEFT
	held_slots = 1
	priority = 100

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

/obj/hud/inventory/organs/left_hand_held/add_held_object(var/obj/item/I,var/messages = TRUE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.left_item = I.defer_click_on_object()

	return .

/obj/hud/inventory/organs/left_hand_held/remove_object(var/obj/item/I,var/turf/drop_loc)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.left_item == I)
			A.left_item = null

	return .

/obj/hud/inventory/organs/right_hand_held
	name = "right hand slot"
	id = BODY_HAND_RIGHT
	icon_state = "right_hand"
	screen_loc = "CENTER-0.5,BOTTOM"
	click_flags = RIGHT_HAND
	item_slot = SLOT_HAND_RIGHT
	held_slots = 1
	priority = 100

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

/obj/hud/inventory/organs/right_hand_held/add_held_object(var/obj/item/I,var/messages = TRUE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.right_item = I.defer_click_on_object()

/obj/hud/inventory/organs/right_hand_held/remove_object(var/obj/item/I,var/turf/drop_loc)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.right_item == I)
			A.right_item = null

	return .
