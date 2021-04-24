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
		PIERCE = 10,
		ARCANE = 20,
		HEAT = -20,
		COLD = 20
	)

	dyeable = TRUE

	polymorphs = list(
		"base" = "#FFFFFF"
	)

	value = 40

/obj/item/clothing/overwear/coat/polymorphic/shaleez
	polymorphs = list(
		"base" = COLOR_CRIMSON,
		"sleeve" = COLOR_WHITE,
		"buttons" = COLOR_GOLD
	)