/obj/item/clothing/overwear/armor/hardsuit/engineering
	name = "engineering hardsuit"
	icon = 'icons/obj/items/clothing/suit/engineering_rig.dmi'
	rarity = RARITY_UNCOMMON
	value = 200

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_B,
		PIERCE = ARMOR_C,
		LASER = ARMOR_D,
		MAGIC = -ARMOR_B,
		HEAT = ARMOR_A,
		COLD = ARMOR_A,
		BOMB = ARMOR_D,
		BIO = ARMOR_C,
		RAD = ARMOR_A
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