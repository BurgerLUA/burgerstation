/obj/item/storage/blood_box/
	name = "blood box"
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "bloodbox"

	is_container = TRUE
	container_max_size = SIZE_4
	size = SIZE_4*3

	dynamic_inventory_count = 3

	value = 20

/obj/item/storage/blood_box/fill_inventory()
	new /obj/item/clothing/head/hat/tricorn(src)
	new /obj/item/clothing/neck/neck_wrap(src)
	new /obj/item/clothing/overwear/coat/trench(src)
	. = ..()
