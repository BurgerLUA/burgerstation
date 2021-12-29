/obj/item/clothing/overwear/armor/space_military
	name = "space military armor"
	desc = "Military. In space!"
	desc_extended = "Armor made from hardened carbon fibres."
	icon = 'icons/obj/item/clothing/suit/space_military_new.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 20,
		BLUNT = 60,
		PIERCE = 60,
		LASER = -40,
		ARCANE = -40,
		HEAT = 20,
		COLD = 20,
		BOMB = 20,
		BIO = 20,
		RAD = 20,
		PAIN = 60
	)

	size = SIZE_6

	protected_limbs =list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	value = 1000

	dyeable = TRUE

	polymorphs = list(
		"armor" = "#303030",
		"lights" = "#00137F"
	)
