/obj/item/clothing/belt/storage
	name = "utility belt"
	icon = 'icons/obj/items/clothing/belts/tool.dmi'
	desc = "Don't make me get the belt."
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed."

	is_container = TRUE

	dynamic_inventory_count = MAX_INVENTORY_X

	size = SIZE_3

	container_max_size = SIZE_2

	weight = WEIGHT_3

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D
	)

/obj/item/clothing/belt/storage/medical
	name = "medical belt"
	icon = 'icons/obj/items/clothing/belts/medical.dmi'
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed. This one is medical themed."

/obj/item/clothing/belt/storage/medical/filled/fill_inventory()
	new /obj/item/container/beaker/bottle/bicaridine(src)
	new /obj/item/container/beaker/bottle/kelotane(src)
	new /obj/item/container/beaker/bottle/dylovene(src)
	new /obj/item/container/syringe(src)
	new /obj/item/container/medicine/bandage/advanced(src)
	new /obj/item/container/medicine/ointment/advanced(src)
	new /obj/item/container/medicine/trauma_kit(src)
	new /obj/item/container/medicine/burn_kit(src)
	return ..()