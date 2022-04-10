/obj/hud/inventory/organs/head
	name = "head slot"
	icon_state = "slot_head"
	id = BODY_HEAD
	screen_loc = "LEFT:1,BOTTOM:16+4"

	item_slot = SLOT_HEAD


	max_slots = 2 //Extra slot for blob head.
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 75

/obj/hud/inventory/organs/neck
	name = "neck slot"
	icon_state = "slot_neck"
	id = BODY_NECK
	screen_loc = "LEFT+1:2,BOTTOM:15+3"

	item_slot = SLOT_NECK

	max_slots = 3
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 50

/obj/hud/inventory/organs/face
	name = "face slot"
	icon_state = "slot_face"
	id = BODY_FACE
	screen_loc = "LEFT+1:2,BOTTOM+4:16"

	item_slot = SLOT_FACE

	max_slots = 3
	worn = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 50


/obj/hud/inventory/organs/ear
	name = "ear slot"
	id = BODY_EARS
	icon_state = "slot_ears"
	screen_loc = "LEFT:3+2,BOTTOM+3:15"

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
	screen_loc = "LEFT:1+2,BOTTOM:12+3"
	item_slot = SLOT_EYES
	worn_slots = 1

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB
*/

/*
/obj/hud/inventory/organs/special
	name = "special slot"
	icon_state = "square_trim"
	id = BODY_SPECIAL
	screen_loc = "CENTER+4,BOTTOM:12"
	item_slot = SLOT_SPECIAL
	held_slots = 1

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB
*/
