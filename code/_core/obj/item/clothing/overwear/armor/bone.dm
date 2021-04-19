/obj/item/clothing/overwear/armor/bone
	name = "bone armor"
	icon = 'icons/obj/item/clothing/suit/bone_armor.dmi'
	desc = "I've got a BONE to pick with ya!"
	desc_extended = "Armor made from bones. Metal as fuck."
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		ARCANE = 20,
		HEAT = 60,
		DARK = 60,
		HOLY = -60,
		PAIN = 60
	)

	size = SIZE_6

	value = 500