/obj/item/clothing/overwear/hardsuit/mining
	name = "mining hardsuit"
	icon = 'icons/obj/items/clothing/suit/hardsuit_mining.dmi'
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
	weight = WEIGHT_7

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/mining)

	slowdown_mul_worn = 1.2

	value = 80