/obj/item/clothing/overwear/armor/prototype
	name = "prototype carbon fibre armor"
	desc = "It's a secret to everybody."
	desc_extended = "A suit made from hardened carbon fibres, currently undergoing testing by the Nanotrasen Science Division."
	icon = 'icons/obj/item/clothing/suit/captain_suit.dmi'

	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_CLUB,
		ARCANE = -AP_CLUB,
		PAIN = AP_CLUB
	)

	size = SIZE_6

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	value = 800