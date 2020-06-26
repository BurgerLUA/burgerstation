/obj/item/clothing/uniform/slav
	name = "matroska shirt and slacks"
	icon = 'icons/obj/items/clothing/uniforms/slav.dmi'

	item_slot = SLOT_TORSO | SLOT_GROIN

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 25,
		BLUNT = 15,
		PIERCE = 25,
		LASER = -10,
		MAGIC = 25,
		HEAT = 10,
		COLD = 30,
		BOMB = 20,
		BIO = 0,
		RAD = 20,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 15
	)

	value = 70