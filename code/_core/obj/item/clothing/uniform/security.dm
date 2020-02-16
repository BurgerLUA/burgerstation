/obj/item/clothing/uniform/security
	name = "security uniform"
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/items/clothing/uniforms/security.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		MAGIC = -ARMOR_D,
		HEAT = ARMOR_E
	)

	value = 10


/obj/item/clothing/uniform/ABOMB
	name = "\improper A.B.O.M.B. uniform"
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/items/clothing/uniforms/ABOMB.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		LASER = -ARMOR_D,
		MAGIC = -ARMOR_D,
		COLD = ARMOR_D,
		BOMB = ARMOR_C
	)

	value = 20

/obj/item/clothing/uniform/tacticool
	name = "tacticool uniform"
	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET
	icon = 'icons/obj/items/clothing/uniforms/tacticool.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		LASER = -ARMOR_D,
		MAGIC = -ARMOR_D,
		COLD = ARMOR_D
	)

	value = 30