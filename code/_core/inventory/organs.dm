/obj/inventory/organs/
	name = "head slot"
	held_slots = 0
	worn_slots = 0
	max_weight = 100
	max_size = 100

	icon = 'icons/hud/inventory.dmi'
	icon_state = "square"

	screen_loc = "CENTER,CENTER"

	attack_damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0)

/obj/inventory/organs/head
	name = "head slot"
	screen_loc = "LEFT,BOTTOM+3"
	worn_slots = 1

/obj/inventory/organs/face
	name = "face slot"
	screen_loc = "LEFT+1,BOTTOM+3"
	worn_slots = 1

/obj/inventory/organs/left_ear
	name = "left ear slot"
	screen_loc = "LEFT,BOTTOM+2"
	worn_slots = 1

/obj/inventory/organs/right_ear
	name = "right ear slot"
	screen_loc = "LEFT+1,BOTTOM+2"
	worn_slots = 1

/obj/inventory/organs/torso
	name = "torso slot"
	screen_loc = "LEFT,BOTTOM+1"
	worn_slots = 1

	item_slot = SLOT_TORSO

/obj/inventory/organs/groin
	name = "belt slot"
	screen_loc = "LEFT + 1,BOTTOM+1"
	worn_slots = 1

	item_slot = SLOT_BELT

/obj/inventory/organs/left_foot
	name = "left foot slot"
	screen_loc = "LEFT,BOTTOM"
	item_slot = SLOT_FOOT_LEFT
	worn_slots = 1

/obj/inventory/organs/right_foot
	name = "right foot slot"
	screen_loc = "LEFT + 1,BOTTOM"
	item_slot = SLOT_FOOT_RIGHT
	worn_slots = 1

/obj/inventory/organs/left_hand
	name = "left hand slot"
	icon_state = "left_hand"
	screen_loc = "CENTER+0.5,BOTTOM"
	click_flags = LEFT_HAND
	attack_damage = list(BRUTE = 0, BURN = 10, TOX = 0, OXY = 0)
	item_slot = SLOT_HAND_LEFT
	worn_slots = 1
	held_slots = 1

/obj/inventory/organs/right_hand
	name = "right hand slot"
	icon_state = "right_hand"
	screen_loc = "CENTER-0.5,BOTTOM"
	click_flags = RIGHT_HAND
	attack_damage = list(BRUTE = 10, BURN = 0, TOX = 0, OXY = 0)
	item_slot = SLOT_HAND_RIGHT
	worn_slots = 1
	held_slots = 1