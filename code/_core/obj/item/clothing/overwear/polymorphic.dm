/obj/item/clothing/overwear/coat/polymorphic
	name = "coat"
	desc = "A nice coat."
	icon = 'icons/obj/items/clothing/suit/jacket.dmi'

	rarity = RARITY_COMMON

	polymorphic = TRUE

	no_initial_blend = TRUE

	is_container = TRUE
	dynamic_inventory_count = 1

	container_max_size = SIZE_2

	size = SIZE_3
	weight = WEIGHT_3

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		MAGIC = ARMOR_D,
		COLD = ARMOR_C
	)

	polymorphs = list(
		"base" = "#FFFFFF",
		"sleeve" = "#FFFFFF",
		"buttons" = "#FFFFFF"
	)

	value = 30

/obj/item/clothing/overwear/coat/polymorphic/shaleez
	polymorphs = list(
		"base" = "#FFFFFF",
		"sleeve" = "#FFFFFF",
		"buttons" = "#FFFFFF"
	)