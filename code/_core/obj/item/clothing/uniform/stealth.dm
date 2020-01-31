/obj/item/clothing/uniform/stealth
	name = "stealth uniform"
	desc = "SM DELAM CALL THE SHUTTLE"
	icon = 'icons/obj/items/clothing/uniforms/stealth.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		LASER = -ARMOR_D,
		MAGIC = ARMOR_C,
		HEAT = ARMOR_D,
		COLD = ARMOR_D,
		BOMB = ARMOR_D
	)