/obj/item/clothing/uniform/mummy
	name = "mummy wraps"
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/items/clothing/uniforms/mummy.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = ARMOR_E,
		PIERCE = ARMOR_E,
		LASER = -ARMOR_E,
		MAGIC = ARMOR_B,
		HEAT = ARMOR_C,
		COLD = -ARMOR_D,
		HOLY = ARMOR_C,
		DARK = ARMOR_C
	)
