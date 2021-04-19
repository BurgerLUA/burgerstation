
/obj/item/clothing/overwear/armor/carbon
	name = "carbon armor"
	desc = "Military. In space!"
	desc_extended = "Armor made from hardened carbon fibres."
	icon = 'icons/obj/item/clothing/suit/carbon.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 40,
		BLUNT = AP_CLUB,
		PIERCE = 40,
		LASER = 40,
		ARCANE = -AP_CLUB,
		HEAT = 40,
		COLD = 40,
		BOMB = AP_CLUB,
		BIO = 40,
		RAD = 40,
		PAIN = AP_CLUB
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