/obj/hud/inventory/dynamic/bank
	name = "bank space"
	icon_state = "square_round"

	max_size = SIZE_10
	max_slots = 1

	drag_to_take = FALSE

	flags = FLAGS_HUD_INVENTORY | FLAGS_HUD_SPECIAL | FLAGS_HUD_CONTAINER

	should_add_to_advanced = FALSE

	priority = -101


/obj/hud/inventory/dynamic/bank/can_slot_object(var/obj/item/I,var/messages = FALSE,var/bypass=FALSE)

	if(!bypass && length(I.inventories) && I.size > 3)
		if(messages) owner.to_chat(span("warning","The bank does not allow the storage of large containers."))
		return FALSE

	. = ..()