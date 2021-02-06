/obj/hud/inventory/organs/torso //Undershirt + Shirt
	name = "torso slot"
	icon_state = "slot_torso"
	id = BODY_TORSO
	screen_loc = "LEFT+1,BOTTOM+2"
	max_slots = 2
	worn = TRUE

	item_slot = SLOT_TORSO | SLOT_TORSO_U

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	priority = 100

/obj/hud/inventory/organs/torso_o
	name = "armor slot"
	icon_state = "slot_torso_o"
	id = BODY_TORSO_O
	screen_loc = "LEFT,BOTTOM+2"
	max_slots = 2
	worn = TRUE

	item_slot = SLOT_TORSO_O | SLOT_TORSO_A

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_WORN | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 90

/obj/hud/inventory/organs/torso_b
	name = "back slot"
	icon_state = "slot_torso_b"
	id = BODY_TORSO_B
	screen_loc = "CENTER-3,BOTTOM"
	max_slots = 1
	worn = TRUE

	item_slot = SLOT_TORSO_B

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

	priority = 10

/obj/hud/inventory/organs/torso_ob
	name = "holster"
	icon_state = "slot_torso_ob"
	id = BODY_TORSO_OB
	screen_loc = "CENTER-4,BOTTOM"
	max_slots = 1

	item_slot = SLOT_TORSO_OB

	essential = TRUE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

	max_size = 1000

	drag_to_take = FALSE

	item_blacklist = list(
		/obj/item/clothing
	)

	priority = 1

/obj/hud/inventory/organs/torso_ob/add_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE,var/silent=FALSE)

	. = ..()

	if(. && is_advanced(owner)) //Now this is shitcode
		var/mob/living/advanced/A = owner
		A.holster_item = I.defer_click_on_object(null,null,null)

	return .

/obj/hud/inventory/organs/torso_ob/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0,var/silent=FALSE)

	. = ..()

	if(. && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.holster_item == I)
			A.holster_item = null

	return .