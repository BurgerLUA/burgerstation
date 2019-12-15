/obj/item/clothing/overwear/armor/bone_armor
	name = "bone armor"
	icon = 'icons/obj/items/clothing/suit/bone_armor.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB
	rarity = RARITY_RARE

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_C,
		PIERCE = ARMOR_C,
		HEAT = ARMOR_A,
	)

	size = SIZE_6
	weight = WEIGHT_4