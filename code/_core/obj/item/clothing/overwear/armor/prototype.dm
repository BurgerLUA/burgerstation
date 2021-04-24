/obj/item/clothing/overwear/armor/prototype
	name = "prototype carbon fibre armor"
	desc = "It's a secret to everybody."
	desc_extended = "A suit made from hardened carbon fibres, currently undergoing testing by the Nanotrasen Science Division."
	icon = 'icons/obj/item/clothing/suit/captain_suit.dmi'

	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 60,
		LASER = -60,
		ARCANE = -60,
		PAIN = 60
	)

	size = SIZE_6

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	value = 800