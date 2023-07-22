/obj/item/clothing/overwear/armor/halo/spartan
	name = "MJOLNIR Mark V armor"
	desc = "Spartans! Yay!"
	desc_extended = "An armored protective suit worn by the Spartans."
	icon = 'icons/obj/item/clothing/suit/spartan.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 90,
		BLUNT = 40,
		PIERCE = 80,
		LASER = 80,
		ARCANE = -40,
		HEAT = 80,
		COLD = 40,
		BOMB = 60,
		BIO = 20,
		RAD = 20,
		PAIN = 60
	)

	size = SIZE_5

	flags_clothing = FLAG_CLOTHING_SPARTAN
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	value = 300
