/obj/item/clothing/overwear/armor/prototype
	name = "prototype carbon fibre armor"
	desc = "It's a secret to everybody."
	desc_extended = "A suit made from hardened carbon fibres, currently undergoing testing by the Nanotrasen Science Division."
	icon = 'icons/obj/item/clothing/suit/captain_suit.dmi'

	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 25,
		BLUNT = 100,
		PIERCE = 50,
		LASER = -50,
		MAGIC = -75,
		HEAT = 50
	)

	size = SIZE_6
	weight = WEIGHT_4

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	value = 200