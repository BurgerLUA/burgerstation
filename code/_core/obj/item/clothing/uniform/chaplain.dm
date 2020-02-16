/obj/item/clothing/uniform/priest
	name = "priest's uniform"
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/items/clothing/uniforms/religious.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = ARMOR_E,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_E,
		MAGIC = ARMOR_A,
		HEAT = ARMOR_E,
		COLD = ARMOR_D,
		HOLY = -ARMOR_S,
		DARK = ARMOR_S
	)

	value = 40