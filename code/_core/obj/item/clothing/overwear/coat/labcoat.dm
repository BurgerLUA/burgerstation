/obj/item/clothing/overwear/coat/labcoat
	name = "labcoat"
	desc = "SCIENCE RULES!"
	desc_extended = "Extra pockets not included."
	icon = 'icons/obj/item/clothing/suit/labcoat.dmi'

	defense_rating = list(
		LASER = 25,
		ARCANE = 25,
		HEAT = 25,
		COLD = 25,
		BIO = 25,
	)

	size = SIZE_3



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