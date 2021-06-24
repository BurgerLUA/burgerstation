//Gloves
/obj/hud/inventory/organs/left_hand_worn
	name = "left glove"
	icon_state = "slot_hand_left"
	id = BODY_HAND_LEFT
	screen_loc = "LEFT+2,BOTTOM+1"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT

	max_slots = 2
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 74

/obj/hud/inventory/organs/right_hand_worn
	name = "right glove"
	icon_state = "slot_hand_right"
	id = BODY_HAND_RIGHT
	screen_loc = "LEFT,BOTTOM+1"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_RIGHT

	max_slots = 2
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 75

//Holding
/obj/hud/inventory/organs/left_hand_held
	name = "left hand slot"
	id = BODY_HAND_LEFT_HELD
	icon = 'icons/hud/hud_wide.dmi'
	icon_state = "left_hand"
	screen_loc = "CENTER+0.5,BOTTOM"
	click_flags = LEFT_HAND

	item_slot = SLOT_NONE
	item_slot_mod = SLOT_MOD_NONE

	max_slots = 1

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

	allow_quick_equip = FALSE

	priority = 2

	x_offset = 16

/obj/hud/inventory/organs/left_hand_held/add_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE,var/silent=FALSE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.left_item = I

/obj/hud/inventory/organs/left_hand_held/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0,var/silent=FALSE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.left_item == I)
			A.left_item = null

/obj/hud/inventory/organs/right_hand_held
	name = "right hand slot"
	id = BODY_HAND_RIGHT_HELD
	icon = 'icons/hud/hud_wide.dmi'
	icon_state = "right_hand"
	screen_loc = "CENTER-1.5,BOTTOM"
	click_flags = RIGHT_HAND

	item_slot = SLOT_NONE
	item_slot_mod = SLOT_MOD_NONE

	max_slots = 1

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

	allow_quick_equip = FALSE

	priority = 3

	x_offset = 16

/obj/hud/inventory/organs/right_hand_held/add_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE,var/silent=FALSE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.right_item = I

/obj/hud/inventory/organs/right_hand_held/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0,var/silent=FALSE)
	. = ..()
	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.right_item == I)
			A.right_item = null
