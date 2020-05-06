/obj/item/clothing/overwear/armor/hardsuit/engineering
	name = "engineering hardsuit"
	icon = 'icons/obj/items/clothing/suit/engineering_rig.dmi'
	rarity = RARITY_UNCOMMON
	value = 200

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 15,
		MAGIC = -50,
		HEAT = 75,
		COLD = 75,
		BOMB = 15,
		BIO = 25,
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