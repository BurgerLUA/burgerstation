/obj/hud/inventory/organs/secure
	name = "secure bluespace storage slot"
	icon_state = "slot_secure"
	id = "secure"
	screen_loc = "LEFT+1:1,BOTTOM:12"

	item_slot = SLOT_NONE
	item_slot_mod = SLOT_MOD_NONE

	max_size = 100
	max_slots = 1
	worn = FALSE

	drag_to_take = FALSE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_MOB

	priority = 1000

	essential = TRUE

	item_bypass = list()

	item_whitelist = list(/obj/item/storage/secure)

	ultra_persistant = TRUE

	light_mod = 0

/obj/hud/inventory/dynamic/secure
	name = "secure space"
	icon_state = "square_round"

	max_size = SIZE_2
	max_slots = 1

	drag_to_take = FALSE

	flags_hud = FLAG_HUD_INVENTORY | FLAG_HUD_SPECIAL | FLAG_HUD_CONTAINER

	should_add_to_advanced = FALSE

	priority = -101


/obj/hud/inventory/dynamic/secure/can_slot_object(var/obj/item/I,var/messages = FALSE,var/bypass=FALSE)

	if(!bypass)
		if(length(I.inventories) && I.size >= SIZE_2)
			if(messages) owner.to_chat(span("warning","The secure storage does not allow the storage of large containers."))
			return FALSE

		if(I.can_save)
			if(messages) owner.to_chat(span("warning","This type of object cannot be stored."))
			return FALSE

		if(I.contraband)
			if(messages) owner.to_chat(span("warning","This type of object cannot be stored."))
			return FALSE

	. = ..()