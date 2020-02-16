/obj/item/clothing/overwear/coat/winter/bomber
	name = "bomber jacket"
	desc = "Wait this actually protects agains bombs what the fuck."
	icon = 'icons/obj/items/clothing/suit/bomberjacket.dmi'
	additional_clothing = list() // no hood

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_E,
		LASER = -ARMOR_E,
		MAGIC = ARMOR_E,
		HEAT = -ARMOR_D,
		COLD = ARMOR_B,
		BOMB = ARMOR_C
	)

	size = SIZE_3
	weight = WEIGHT_3

	value = 20