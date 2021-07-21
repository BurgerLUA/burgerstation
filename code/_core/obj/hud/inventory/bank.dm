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

	if(!bypass && I.size > 3 && I.is_container)
		if(length(I.inventories) && I.container_max_size)
			var/filled_slots = 0
			for(var/k in I.inventories)
				var/obj/hud/inventory/I3 = k
				filled_slots += length(I3.contents)
			if(filled_slots)
				if(messages) owner.to_chat(span("warning","The bank only allows the storage of large containers if they are empty."))
				return FALSE
			var/mob/living/advanced/A = owner
			for(var/obj/hud/inventory/dynamic/B in A.inventory)	// this check closes the soon-to-be banked container's storage if its open
				if(B.loc.type == I.type)						// however it does not remove the close button as there is no way to single it out (or at least i couldnt think of one)
					B.alpha = 0
					B.mouse_opacity = 0

	. = ..()

/obj/hud/inventory/dynamic/bank/add_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE,var/silent=FALSE)

	if(I.size > 3 && I.is_container)
		if(length(I.inventories) && I.container_max_size)
			I.is_container = FALSE
			I.dynamic_inventory_count = 0

	. = ..()

/obj/hud/inventory/dynamic/bank/remove_object(var/obj/item/I,var/turf/drop_loc,var/pixel_x_offset=0,var/pixel_y_offset=0,var/silent=FALSE)

	if(I.size > 3 && I.container_max_size && !I.is_container)
		I.dynamic_inventory_count = initial(I.dynamic_inventory_count)
		I.is_container = TRUE

	. = ..()
