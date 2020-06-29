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
	weight = WEIGHT_0
	value = 10

	defense_rating = list(
		MAGIC = 25
	)

	dyeable = TRUE

/obj/item/clothing/head/hat/paperbag/update_icon()

	. = ..()

	var/filled_slots = 0
	for(var/obj/hud/inventory/I in src.inventories)
		filled_slots += length(I.held_objects)

	if(filled_slots == 0)
		icon_state = "paperbag1"
	else icon_state = "paperbag2"

	return .

/obj/item/clothing/head/hat/paperbag/update_inventory()
	. = ..()
	update_sprite()
	return .