
/obj/item/clothing/overwear/armor/carbon
	name = "carbon armor"
	icon = 'icons/obj/item/clothing/suit/carbon.dmi'

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

	dyeable = TRUE

	polymorphs = list(
		"armor" = "#FFFFFF",
		"detail" = "#FFFFFF",
		"under" = "#FFFFFF"
	)

	no_initial_blend = TRUE

/obj/item/clothing/overwear/armor/carbon/nanotrasen

	dyeable = TRUE

	polymorphs = list(
		"armor" = COLOR_NANOTRASEN,
		"detail" = COLOR_GOLD,
		"under" = "#FFFFFF"
	)