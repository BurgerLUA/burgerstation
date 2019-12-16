/obj/item/clothing/overwear/armor/explorer_suit
	name = "explorer's suit"
	icon = 'icons/obj/items/clothing/suit/explorer_suit.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_OVER_MOB
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = ARMOR_C,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_C,
		HEAT = ARMOR_A,
		COLD = -ARMOR_D,
	)
	additional_clothing = list(/obj/item/clothing/head/helmet/attached/explorer_suit)

	size = SIZE_6
	weight = WEIGHT_4