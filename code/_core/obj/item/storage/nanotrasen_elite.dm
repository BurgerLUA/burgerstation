/obj/item/storage/nanotrasen_elite
	name = "nanotrasen security veteran kit"

	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "largebox"

	size = SIZE_3

	is_container = TRUE
	container_max_size = SIZE_2

	dynamic_inventory_count = 5

	value = 150

/obj/item/storage/nanotrasen_elite/fill_inventory()
	new /obj/item/clothing/overwear/coat/nanotrasen_officer(src)
	new /obj/item/clothing/overwear/armor/reinforced(src)
	new /obj/item/clothing/shirt/nanotrasen_officer(src)
	new /obj/item/clothing/pants/nanotrasen_officer(src)
	new /obj/item/clothing/head/helmet/tactical/advanced/nanotrasen(src)
	. = ..()