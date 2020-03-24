/obj/item/clothing/overwear/coat/labcoat
	name = "labcoat"
	icon = 'icons/obj/items/clothing/suit/labcoat.dmi'

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		LASER = ARMOR_E,
		MAGIC = ARMOR_B,
		HEAT = ARMOR_C,
		COLD = ARMOR_C,
		BOMB = ARMOR_C,
		BIO = ARMOR_B
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