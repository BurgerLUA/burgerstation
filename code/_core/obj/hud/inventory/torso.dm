/obj/hud/inventory/organs/torso //Undershirt + Shirt
	name = "torso slot"
	icon_state = "slot_torso"
	id = BODY_TORSO
	screen_loc = "LEFT+1,BOTTOM+2"
	worn_slots = 2

	item_slot = SLOT_TORSO | SLOT_TORSO_U

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 100

/obj/hud/inventory/organs/torso_o
	name = "coat slot"
	icon_state = "slot_torso_o"
	id = BODY_TORSO_O
	screen_loc = "LEFT,BOTTOM+2"
	worn_slots = 2

	item_slot = SLOT_TORSO_O | SLOT_TORSO_A

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE

/obj/hud/inventory/organs/torso_b
	name = "back slot"
	icon_state = "slot_torso_b"
	id = BODY_TORSO_B
	screen_loc = "CENTER-3,BOTTOM"
	worn_slots = 1

	item_slot = SLOT_TORSO_B

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

/obj/hud/inventory/organs/torso_ob
	name = "overwear belt slot"
	icon_state = "slot_torso_ob"
	id = BODY_TORSO_OB
	screen_loc = "CENTER-4,BOTTOM"
	held_slots = 1

	item_slot = SLOT_TORSO_OB

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

	max_size = 1000
	max_weight = 1000

	drag_to_take = FALSE

	item_blacklist = list(
		/obj/item/clothing
	)