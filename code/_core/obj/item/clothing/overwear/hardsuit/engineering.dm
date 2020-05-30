/obj/item/clothing/overwear/hardsuit/engineering
	name = "engineering hardsuit"
	icon = 'icons/obj/items/clothing/suit/engineering_rig.dmi'
	rarity = RARITY_UNCOMMON
	value = 200

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		MAGIC = -100,
		HEAT = 100,
		COLD = 100,
		BOMB = 25,
		BIO = 75,
		RAD = 75
	)

	size = SIZE_7
	weight = WEIGHT_5

	additional_clothing = list(
		/obj/item/clothing/head/helmet/hardsuit/engineering,
		/obj/item/clothing/hands/gloves/engineering,
		/obj/item/clothing/hands/gloves/engineering/left,
		/obj/item/clothing/feet/shoes/engineering,
		/obj/item/clothing/feet/shoes/engineering/left
	)

	slowdown_mul_worn = 1.1