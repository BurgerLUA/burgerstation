/obj/hud/inventory/organs/groin/pocket
	name = "pocket"
	id = "pocket"
	icon_state = "slot_pocket"
	screen_loc = "CENTER,BOTTOM+3"
	max_slots = 1
	worn = FALSE

	item_slot = SLOT_NONE
	item_slot_mod = SLOT_MOD_NONE

	max_size = SIZE_2
	//should_draw = FALSE
	drag_to_take = FALSE

	essential = TRUE

	item_bypass = list()

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_MOB

	drop_on_death = TRUE

/obj/hud/inventory/organs/groin/pocket/right
	name = "left lower pocket"
	id = "pocket01"
	screen_loc = "CENTER+3,BOTTOM"

	priority = 11

/obj/hud/inventory/organs/groin/pocket/left
	name = "right lower pocket"
	id = "pocket02"
	screen_loc = "CENTER+4,BOTTOM"

	priority = 10

/obj/hud/inventory/organs/groin/pocket/contract
	name = "contract slot"
	icon_state = "slot_contract"
	id = "contract"
	screen_loc = "RIGHT,CENTER+4"

	priority = 1000

	item_whitelist = list(/obj/item/contract)