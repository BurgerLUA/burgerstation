//Gloves
/obj/hud/inventory/organs/left_hand_worn
	name = "left glove"
	icon_state = "slot_hand_left"
	id = BODY_HAND_LEFT
	screen_loc = "LEFT:3+2,BOTTOM+2:14"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_LEFT

	max_slots = 2
	worn = TRUE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_WORN | FLAG_HUD_MOB

	priority = 74

/obj/hud/inventory/organs/right_hand_worn
	name = "right glove"
	icon_state = "slot_hand_right"
	id = BODY_HAND_RIGHT
	screen_loc = "LEFT:1,BOTTOM+2:14"

	item_slot = SLOT_HAND
	item_slot_mod = SLOT_MOD_RIGHT

	max_slots = 2
	worn = TRUE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_WORN | FLAG_HUD_MOB

	priority = 75

//Holding
/obj/hud/inventory/organs/left_hand_held
	name = "left hand slot"
	id = BODY_HAND_LEFT_HELD
	icon = 'icons/hud/hud_wide.dmi'
	icon_state = "left_hand"
	screen_loc = "CENTER+0.5,BOTTOM:12"
	click_flags = LEFT_HAND

	item_slot = SLOT_NONE
	item_slot_mod = SLOT_MOD_NONE

	max_slots = 1

	essential = TRUE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	allow_quick_equip = FALSE

	priority = 2

	x_offset = 16

	light_mod = 1

/obj/hud/inventory/organs/left_hand_held/update_sprite()

	if(owner && owner.client)
		var/client/C = owner.client
		if(C.settings.loaded_data["compact_mode"])
			icon = initial(icon)
			icon_state = "left_hand_small"
			screen_loc = "CENTER+0.5,BOTTOM:12"
			x_offset = 0
		else
			icon = initial(icon)
			icon_state = initial(icon_state)
			screen_loc = initial(screen_loc)
			x_offset = initial(x_offset)
		for(var/obj/item/I in src.vis_contents)
			I.pixel_x = initial(I.pixel_x) + x_offset
			I.pixel_y = initial(I.pixel_y) + y_offset


	. = ..()

/obj/hud/inventory/organs/right_hand_held
	name = "right hand slot"
	id = BODY_HAND_RIGHT_HELD
	icon = 'icons/hud/hud_wide.dmi'
	icon_state = "right_hand"
	screen_loc = "CENTER-1.5:-1,BOTTOM:12"
	click_flags = RIGHT_HAND

	item_slot = SLOT_NONE
	item_slot_mod = SLOT_MOD_NONE

	max_slots = 1

	essential = TRUE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	allow_quick_equip = FALSE

	priority = 3

	x_offset = 16

	light_mod = 1

/obj/hud/inventory/organs/right_hand_held/update_sprite()

	if(owner && owner.client)
		var/client/C = owner.client
		if(C.settings.loaded_data["compact_mode"])
			icon = initial(icon)
			icon_state = "right_hand_small"
			screen_loc = "CENTER-0.5,BOTTOM:12"
			x_offset = 0
		else
			icon = initial(icon)
			icon_state = initial(icon_state)
			screen_loc = initial(screen_loc)
			x_offset = initial(x_offset)
		for(var/obj/item/I in src.vis_contents)
			I.pixel_x = initial(I.pixel_x) + x_offset
			I.pixel_y = initial(I.pixel_y) + y_offset

	. = ..()


/obj/hud/inventory/organs/right_hand_held/update_overlays()
	. = ..()
	if(owner?.client?.selected_hand == click_flags)
		var/image/I = new/image(initial(icon),"[icon_state]_selected")
		add_overlay(I)