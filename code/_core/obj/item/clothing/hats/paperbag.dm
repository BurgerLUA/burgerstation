/obj/item/clothing/head/hat/paperbag
	name = "paper bag"
	desc = "Put the MONEY in the BAG! PUT IT IN!"
	desc_extended = "Holds items but preferably food. Can be dyed. Also a fashion statement when worn."
	icon = 'icons/obj/item/clothing/hats/paperbag.dmi'
	icon_state = "paperbag"

	dynamic_inventory_count = 7
	container_held_slots = 1
	container_max_size = SIZE_1

	size = SIZE_2
	is_container = TRUE

	value = 10

	defense_rating = list(
		ARCANE = 25
	)

	dyeable = TRUE

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE

/obj/item/clothing/head/hat/paperbag/update_icon()

	. = ..()

	var/filled_slots = 1
	for(var/k in src.inventories)
		var/obj/hud/inventory/I = k
		filled_slots += length(I.held_objects)

	icon_state = "[initial(icon_state)][clamp(filled_slots,1,2)]"

	return .

/obj/item/clothing/head/hat/paperbag/update_inventory()
	. = ..()
	update_sprite()
	return .