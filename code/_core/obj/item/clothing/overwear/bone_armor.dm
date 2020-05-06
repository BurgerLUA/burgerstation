/obj/item/clothing/overwear/armor/bone_armor
	name = "bone armor"
	icon = 'icons/obj/items/clothing/suit/bone_armor.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_RARE

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		HEAT = 75,
	)

	size = SIZE_6
	weight = WEIGHT_4

	value = 300