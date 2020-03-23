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

	color_primary = "#FFFFFF"
	color_secondary = "#FFFFFF"
	color_tertiary = "#FFFFFF"

	color_primary_desc = "coat"
	color_secondary_desc = "sleeves"
	color_tertiary_desc = "buttons"

	value = 30

/obj/item/clothing/overwear/coat/polymorphic/shaleez
	color_primary = COLOR_SHALEEZ_RED
	color_secondary = COLOR_WHITE
	color_tertiary = COLOR_GOLD