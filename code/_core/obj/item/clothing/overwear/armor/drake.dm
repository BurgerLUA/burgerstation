/obj/item/clothing/overwear/armor/drake_armor
	name = "ash drake armor"
	desc = "More like Drakeskin Armor, eh?"
	desc_extended = "Armor made from the hardened scales of an Elder Ash Drake."
	icon = 'icons/obj/item/clothing/suit/drake_armor.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_MYTHICAL

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 20,
		ARCANE = 20,
		HEAT = 20,
		COLD = -20,
		HOLY = -40,
		DARK = 40,
		PAIN = 60
	)

	size = SIZE_7

	additional_clothing = list(/obj/item/clothing/head/helmet/drake)

	value = 1100