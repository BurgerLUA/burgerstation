/obj/item/clothing/head/helmet/full/carbon
	name = "space military helmet"
	icon = 'icons/obj/item/clothing/hats/carbon.dmi'
	desc = "Military. In space!"
	desc_extended = "A helmet made from hardened carbon fibres."

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

	size = SIZE_3


	value = 500

	polymorphs = list(
		"visor" = "#FFFFFF",
		"helmet" = "#FFFFFF"
	)

	no_initial_blend = TRUE

	dyeable = TRUE

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE | SLOT_EYES

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