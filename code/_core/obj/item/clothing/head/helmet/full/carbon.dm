/obj/item/clothing/head/helmet/full/carbon
	name = "carbon helmet"
	icon = 'icons/obj/item/clothing/hats/carbon.dmi'
	desc = "Military. In space!"
	desc_extended = "A helmet made from hardened carbon fibres."

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = -AP_CLUB,
		HEAT = AP_AXE,
		COLD = AP_AXE,
		BOMB = AP_AXE,
		BIO = AP_AXE,
		RAD = AP_AXE,
		PAIN = AP_CLUB
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