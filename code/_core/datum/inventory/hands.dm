//Gloves
/obj/inventory/organs/left_hand_worn
	name = "left glove"
	id = BODY_HAND_LEFT
	screen_loc = "LEFT+2,BOTTOM+1"
	item_slot = SLOT_HAND_LEFT
	worn_slots = 1

/obj/inventory/organs/right_hand_worn
	name = "right glove"
	id = BODY_HAND_RIGHT
	screen_loc = "LEFT,BOTTOM+1"
	item_slot = SLOT_HAND_RIGHT
	worn_slots = 1

//Holding
/obj/inventory/organs/left_hand_held
	name = "left hand slot"
	id = BODY_HAND_LEFT
	icon_state = "left_hand"
	screen_loc = "CENTER+0.5,BOTTOM"
	click_flags = LEFT_HAND
	item_slot = SLOT_HAND_LEFT
	held_slots = 1
	priority = 100

	essential = TRUE

/obj/inventory/organs/left_hand_held/add_held_object(var/obj/item/I,var/messages = TRUE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.automatic_left = I.defer_click_on_object()

	return .

/obj/inventory/organs/left_hand_held/remove_object(var/obj/item/I,var/turf/drop_loc)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.automatic_left == I)
			A.automatic_left = null

	return .

/obj/inventory/organs/right_hand_held
	name = "right hand slot"
	id = BODY_HAND_RIGHT
	icon_state = "right_hand"
	screen_loc = "CENTER-0.5,BOTTOM"
	click_flags = RIGHT_HAND
	item_slot = SLOT_HAND_RIGHT
	held_slots = 1
	priority = 100

	essential = TRUE

/obj/inventory/organs/right_hand_held/add_held_object(var/obj/item/I,var/messages = TRUE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.automatic_right = I.defer_click_on_object()

/obj/inventory/organs/right_hand_held/remove_object(var/obj/item/I,var/turf/drop_loc)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.automatic_right == I)
			A.automatic_right = null

	return .
