
/obj/item/clothing/overwear/armor/carbon
	name = "space military armor"
	desc = "Military. In space!"
	desc_extended = "Armor made from hardened carbon fibres."
	icon = 'icons/obj/item/clothing/suit/carbon.dmi'

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

	dyeable = TRUE

	polymorphs = list(
		"armor" = "#FFFFFF",
		"detail" = "#FFFFFF",
		"under" = "#FFFFFF"
	)

	no_initial_blend = TRUE

	slowdown_mul_worn = 1.2

/obj/item/clothing/overwear/armor/carbon/nanotrasen
	polymorphs = list(
		"armor" = COLOR_NANOTRASEN,
		"detail" = COLOR_GOLD,
		"under" = "#FFFFFF"
	)

/obj/item/clothing/overwear/armor/carbon/deathsquad
	polymorphs = list(
		"armor" = COLOR_BLACK,
		"detail" = COLOR_CRIMSON,
		"under" = "#FFFFFF"
	)