/obj/item/clothing/overwear/coat/winter/bomber
	name = "bomber jacket"
	desc = "Wait this actually protects agains bombs what the fuck."
	icon = 'icons/obj/items/clothing/suit/bomberjacket.dmi'
	additional_clothing = list() // no hood

	defense_rating = list(
		BLADE = 10,
		BLUNT = 15,
		PIERCE = 10,
		LASER = -10,
		MAGIC = 10,
		HEAT = -15,
		COLD = 50,
		BOMB = 25
	)

	size = SIZE_3
	weight = WEIGHT_3

	value = 20