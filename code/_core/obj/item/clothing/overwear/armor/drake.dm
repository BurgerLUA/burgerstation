/obj/item/clothing/overwear/armor/drake_armor
	name = "ash drake armor"
	icon = 'icons/obj/items/clothing/suit/drake_armor.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = -50,
		MAGIC = 25,
		HEAT = 100,
		COLD = -25
	)

	size = SIZE_7
	weight = WEIGHT_6
	additional_clothing = list(/obj/item/clothing/head/helmet/attached/drake_armor)

	value = 1000