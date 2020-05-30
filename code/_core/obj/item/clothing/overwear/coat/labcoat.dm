/obj/item/clothing/overwear/coat/labcoat
	name = "labcoat"
	icon = 'icons/obj/items/clothing/suit/labcoat.dmi'

	defense_rating = list(
		LASER = 25,
		MAGIC = 50,
		HEAT = 25,
		COLD = 25,
		BIO = 25,
	)

	size = SIZE_3
	weight = WEIGHT_2


	polymorphs = list(
		"base" = "#FFFFFF"
	)

	value = 50

	dyeable = TRUE


/obj/item/clothing/overwear/coat/labcoat/chemist
	polymorphs = list(
		"base" = "#FFFFFF",
		"shoulder" = COLOR_ORANGE
	)

/obj/item/clothing/overwear/coat/labcoat/medical
	polymorphs = list(
		"base" = COLOR_MEDICAL
	)