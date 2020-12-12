/obj/item/clothing/overwear/armor/space_military
	name = "space military armor"
	desc = "Military. In space!"
	desc_extended = "Armor made from hardened carbon fibres."
	icon = 'icons/obj/item/clothing/suit/space_military.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		ARCANE = -75,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 50,
		RAD = 50
	)

	size = SIZE_6

	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	value = 1000