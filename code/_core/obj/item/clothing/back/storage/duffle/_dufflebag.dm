/obj/item/clothing/back/storage/dufflebag/
	name = "dufflebag"
	icon = 'icons/obj/items/clothing/back/dufflebag/white.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*3

	size = MAX_INVENTORY_X*3*SIZE_4
	container_max_size = SIZE_4

	weight = WEIGHT_4


/obj/item/clothing/back/storage/dufflebag/loadout/



/obj/item/clothing/back/storage/dufflebag/loadout/medical
	name = "medical doctor dufflebag"
	color = COLOR_MEDICAL


/obj/item/clothing/back/storage/dufflebag/loadout/medical/fill_inventory()
	new /obj/item/clothing/uniform/jumpsuit/medical_doctor(src)
	new /obj/item/storage/shoebox/colored(src)
	new /obj/item/clothing/overwear/coat/labcoat/medical(src)
	new /obj/item/clothing/belt/storage/medical/filled(src)
	new /obj/item/storage/bags/chemistry(src)
	return ..()