/obj/item/clothing/overwear/armor/hardsuit/engineering
	name = "engineering hardsuit"
	icon = 'icons/obj/items/clothing/suit/engineering_rig.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_E,
		LASER = ARMOR_D,
		MAGIC = -ARMOR_S,
		HEAT = ARMOR_C,
		COLD = ARMOR_B,
		BOMB = ARMOR_D,
		BIO = ARMOR_B,
		RAD = ARMOR_D
	)

	size = SIZE_7
	weight = WEIGHT_7

	additional_clothing = list(
		/obj/item/clothing/head/helmet/hardsuit/engineering,
		/obj/item/clothing/hands/gloves/engineering,
		/obj/item/clothing/hands/gloves/engineering/left,
		/obj/item/clothing/feet/shoes/magboot,
		/obj/item/clothing/feet/shoes/magboot/left
	)

	slowdown_mul_worn = 1.1