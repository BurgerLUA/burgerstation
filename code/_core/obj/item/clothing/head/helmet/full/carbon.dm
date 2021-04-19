/obj/item/clothing/head/helmet/full/carbon
	name = "carbon helmet"
	icon = 'icons/obj/item/clothing/hats/carbon.dmi'
	desc = "Military. In space!"
	desc_extended = "A helmet made from hardened carbon fibres."

	defense_rating = list(
		BLADE = 20,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = -60,
		HEAT = 40,
		COLD = 40,
		BOMB = 40,
		BIO = 40,
		RAD = 40,
		PAIN = 60
	)

	size = SIZE_3


	value = 500

	polymorphs = list(
		"visor" = "#FFFFFF",
		"helmet" = "#FFFFFF"
	)

	no_initial_blend = TRUE

	dyeable = TRUE

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)

/obj/item/clothing/head/helmet/full/carbon/nanotrasen
	polymorphs = list(
		"visor" = COLOR_GOLD,
		"helmet" = COLOR_NANOTRASEN
	)

/obj/item/clothing/head/helmet/full/carbon/deathsquad
	polymorphs = list(
		"visor" = COLOR_BLUE,
		"helmet" = COLOR_BLACK,
		"stripe" = COLOR_CRIMSON
	)

/obj/item/clothing/head/helmet/full/carbon/dummy
	name = "old space swat helmet"
	polymorphs = list(
		"visor" = COLOR_BROWN,
		"helmet" = COLOR_RED
	)