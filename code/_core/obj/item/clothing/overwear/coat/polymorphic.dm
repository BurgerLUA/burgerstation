/obj/item/clothing/overwear/coat/polymorphic
	name = "coat"
	desc = "A nice coat."
	desc_extended = "Can hold a single Size 2 item."
	icon = 'icons/obj/item/clothing/suit/jacket.dmi'

	rarity = RARITY_COMMON



	no_initial_blend = TRUE

	is_container = TRUE
	dynamic_inventory_count = 1

	container_max_size = SIZE_2

	size = SIZE_3


	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 0,
		LASER = 10,
		MAGIC = 25,
		COLD = 25
	)

	dyeable = TRUE

	polymorphs = list(
		"base" = "#FFFFFF"
	)

	value = 30

/obj/item/clothing/overwear/coat/polymorphic/shaleez
	polymorphs = list(
		"base" = COLOR_SHALEEZ_RED,
		"sleeve" = COLOR_WHITE,
		"buttons" = COLOR_GOLD
	)