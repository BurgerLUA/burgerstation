/obj/hud/inventory/organs/head
	name = "head slot"
	icon_state = "slot_head"
	id = BODY_HEAD
	screen_loc = "LEFT,BOTTOM+3"
	item_slot = SLOT_HEAD

	max_slots = 1
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 75

/obj/hud/inventory/organs/neck
	name = "neck slot"
	icon_state = "slot_neck"
	id = BODY_NECK
	screen_loc = "LEFT+2,BOTTOM+2"
	item_slot = SLOT_NECK

	max_slots = 1
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 50

/obj/hud/inventory/organs/face
	name = "face slot"
	icon_state = "slot_face"
	id = BODY_FACE
	screen_loc = "LEFT+1,BOTTOM+3"
	item_slot = SLOT_FACE | SLOT_EYES | SLOT_FACE_WRAP

	max_slots = 3
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 50

/*
/obj/hud/inventory/organs/left_ear
	name = "left ear slot"
	id = BODY_EAR_LEFT
	screen_loc = "LEFT+2,BOTTOM+3"
	item_slot = SLOT_EAR
	worn_slots = 1

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB
*/

/obj/hud/inventory/organs/ear
	name = "ear slot"
	id = BODY_EARS
	icon_state = "slot_ears"
	screen_loc = "LEFT+2,BOTTOM+3"
	item_slot = SLOT_EAR

	max_slots = 1
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 50


/*
/obj/hud/inventory/organs/glasses
	name = "glasses slot"
	icon_state = "SLOT_EYES"
	id = BODY_EYES
	screen_loc = "LEFT+2,BOTTOM+3"
	item_slot = SLOT_EYES
	worn_slots = 1

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE
*/

/*
/obj/hud/inventory/organs/special
	name = "special slot"
	icon_state = "square_trim"
	id = BODY_SPECIAL
	screen_loc = "CENTER+4,BOTTOM"
	item_slot = SLOT_SPECIAL
	held_slots = 1

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE
*/