/obj/item/clothing/overwear/hardsuit/mining
	name = "mining hardsuit"
	desc = "MIIIIINIIIIING DIAAAAMOOOOOONDS!"
	desc_extended = "A hardsuit worn by miners to protect against a variety of hazards, such as rock falls, black lungs, and cave monsters."
	icon = 'icons/obj/item/clothing/suit/hardsuit_mining.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		HEAT = 100,
		COLD = 75,
		BOMB = 25,
		BIO = 75,
		RAD = 75
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/mining)

	slowdown_mul_worn = 1.2

	value = 80