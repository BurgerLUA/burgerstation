/obj/item/clothing/overwear/armor/eod
	name = "bomb suit"
	desc = "Commonly used to assault bank heisters, as well as protect against explosives."
	desc_extended = "A large, extremely protective suit, made specifically to defend against explosives, but works well enough against bullets too."
	icon = 'icons/obj/item/clothing/suit/eod_suit.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT
	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_HAND_LEFT,BODY_HAND_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 75,
		HEAT = -25,
		ARCANE = -75,
		BOMB = 100
	)

	size = SIZE_6

	value = 1500

