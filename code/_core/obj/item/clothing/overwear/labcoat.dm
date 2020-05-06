/obj/item/clothing/overwear/coat/labcoat
	name = "labcoat"
	icon = 'icons/obj/items/clothing/suit/labcoat.dmi'

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		LASER = 10,
		MAGIC = 50,
		HEAT = 25,
		COLD = 25,
		BOMB = 25,
		BIO = 50
	)

	size = SIZE_3
	weight = WEIGHT_2


	polymorphs = list(
		"base" = "#FFFFFF"
	)

	value = 10


/obj/item/clothing/overwear/coat/labcoat/chemist
	polymorphs = list(
		"base" = "#FFFFFF",
		"shoulder" = COLOR_ORANGE
	)

/obj/item/clothing/overwear/coat/labcoat/medical
	polymorphs = list(
		"base" = COLOR_MEDICAL
	)