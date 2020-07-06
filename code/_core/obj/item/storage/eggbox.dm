/obj/item/storage/egg_carton
	name = "egg carton"
	desc = "Stores eggs."
	desc_extended = "Holds eggs."
	icon = 'icons/obj/item/storage/egg_carton.dmi'
	icon_state = "eggbox"

	dynamic_inventory_count = 12
	container_held_slots = 1

	container_whitelist = list(
		/obj/item/container/food/egg/chicken,
	)

	size = SIZE_3
	weight = WEIGHT_1

/obj/item/storage/egg_carton/update_icon()

	. = ..()

	var/filled_slots = 0
	for(var/obj/hud/inventory/I in src.inventories)
		filled_slots += length(I.held_objects)

	icon_state = "[initial(icon_state)][clamp(filled_slots,0,12)]"

	return .

/obj/item/storage/egg_carton/fill_inventory()
	for(var/i=1,i<=dynamic_inventory_count,i++)
		new/obj/item/container/food/egg/chicken(src)
	return ..()

/obj/item/storage/egg_carton/update_inventory()
	. = ..()
	update_sprite()
	return .