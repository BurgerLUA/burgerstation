/obj/item/clothing/belt/storage
	name = "utility belt"
	icon = 'icons/obj/items/clothing/belts/tool.dmi'
	desc = "Don't make me get the belt."
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed."

	is_container = TRUE

	dynamic_inventory_count = 6

	size = 3
	container_max_size = 2

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D
	)