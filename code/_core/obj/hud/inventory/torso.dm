/obj/hud/inventory/organs/torso //Undershirt + Shirt
	name = "torso slot"
	icon_state = "slot_torso"
	id = BODY_TORSO
	screen_loc = "LEFT:2+1,BOTTOM+2:14"
	max_slots = 2
	worn = TRUE

	item_slot = SLOT_TORSO

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_WORN | FLAG_HUD_MOB

	priority = 100

/obj/hud/inventory/organs/torso_o
	name = "armor slot"
	icon_state = "slot_torso_o"
	id = BODY_TORSO_O
	screen_loc = "LEFT:1,BOTTOM+3:15"
	max_slots = 2
	worn = TRUE

	item_slot = SLOT_TORSO_ARMOR

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_WORN | FLAG_HUD_MOB

	priority = 90

	advanced_layering = TRUE

/obj/hud/inventory/organs/torso_b
	name = "back slot"
	icon_state = "slot_torso_b"
	id = BODY_TORSO_B
	screen_loc = "CENTER-4,BOTTOM:11"
	max_slots = 2
	worn = TRUE

	item_slot = SLOT_TORSO_BACK
	item_slot_mod = SLOT_MOD_NONE

	essential = TRUE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	priority = 10

/obj/hud/inventory/organs/torso_b/update_sprite()

	if(owner && owner.client)
		var/client/C = owner.client
		if(C.settings.loaded_data["compact_mode"])
			screen_loc = "LEFT+3:2,BOTTOM:11"
		else
			screen_loc = initial(screen_loc)

	. = ..()

/obj/hud/inventory/organs/torso_ob
	name = "holster"
	icon_state = "slot_torso_ob"
	id = BODY_TORSO_OB
	screen_loc = "CENTER-5,BOTTOM:11"
	max_slots = 1
	worn = FALSE

	item_slot = SLOT_NONE
	item_slot_mod = SLOT_MOD_NONE

	essential = TRUE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	max_size = SIZE_10

	drag_to_take = FALSE

	item_blacklist = list(
		/obj/item/clothing
	)

	priority = 1

/obj/hud/inventory/organs/torso_ob/update_sprite()

	if(owner && owner.client)
		var/client/C = owner.client
		if(C.settings.loaded_data["compact_mode"])
			screen_loc = "LEFT+2:2,BOTTOM:11"
		else
			screen_loc = initial(screen_loc)

	. = ..()