/obj/item/storage/lighting/
	name = "lighting box"

	is_container = TRUE
	container_max_size = SIZE_1

	dynamic_inventory_count = MAX_INVENTORY_X*2

	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "largebox"

	value = 20

/obj/item/storage/lighting/tube
	name = "lighting tube box"

/obj/item/storage/lighting/tube/fill_inventory()
	for(var/i=1,i<=dynamic_inventory_count,i++)
		new/obj/item/light/tube(src)
	return ..()

/obj/item/storage/lighting/bulb
	name = "lighting bulb box"

/obj/item/storage/lighting/bulb/fill_inventory()
	for(var/i=1,i<=dynamic_inventory_count,i++)
		new/obj/item/light/bulb(src)
	return ..()