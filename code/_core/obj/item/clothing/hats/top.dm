/obj/item/clothing/head/hat/top
	name = "top hat"
	icon = 'icons/obj/item/clothing/hats/top.dmi'
	desc = "Classy!"
	desc_extended = "An expensive top hat."

	defense_rating = list(
		BLADE = 10,
		BLUNT = 0,
		PIERCE = 5,
		LASER = 0,
		MAGIC = 50,
		COLD = 25
	)

	size = SIZE_2
	weight = WEIGHT_1

	value = 30

	dyeable = TRUE

	polymorphs = list(
		"base" = COLOR_BLACK,
		"stripe" = COLOR_WHITE
	)

	no_initial_blend = TRUE