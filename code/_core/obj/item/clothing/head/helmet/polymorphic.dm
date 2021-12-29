/obj/item/clothing/head/helmet/polymorphic
	name = "protective helmet"
	icon = 'icons/obj/item/clothing/hats/security_new.dmi'
	desc = "RUSH B"
	desc_extended = "Standard-issue of the Nanotrasen security force. Protects your head from bullets."

	defense_rating = list(
		BLADE = 20,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = -40,
		BOMB = 40,
		PAIN = 60
	)

	size = SIZE_3


	value = 40

	dyeable = TRUE

	polymorphs = list(
		"base" = "#FFFFFF",
		"ears" = "#FFFFFF",
		"stripe" = "#FFFFFF"
	)

	no_initial_blend = TRUE

/obj/item/clothing/head/helmet/polymorphic/nanotrasen
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ears" = COLOR_NANOTRASEN,
		"stripe" = COLOR_NANOTRASEN
	)

/obj/item/clothing/head/helmet/polymorphic/recruit
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ears" = COLOR_RECRUIT,
		"stripe" = COLOR_RECRUIT
	)

/obj/item/clothing/head/helmet/polymorphic/engineering
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ears" = COLOR_ENGINEERING,
		"stripe" = COLOR_ENGINEERING
	)

/obj/item/clothing/head/helmet/polymorphic/medical
	polymorphs = list(
		"base" = COLOR_WHITE,
		"ears" = COLOR_MEDICAL,
		"stripe" = COLOR_MEDICAL
	)

/obj/item/clothing/head/helmet/polymorphic/space_military
	polymorphs = list(
		"base" = COLOR_WHITE,
		"ears" = COLOR_BLACK,
		"stripe" = COLOR_BLACK
	)

/obj/item/clothing/head/helmet/polymorphic/reinforced
	name = "reinforced protective helmet"
	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 60,
		LASER = 40,
		ARCANE = -60,
		BOMB = 40,
		PAIN = 60
	)

/obj/item/clothing/head/helmet/polymorphic/reinforced/ntops
	name = "NT ops reinforced protective helmet"
	polymorphs = list(
		"base" = COLOR_WHITE,
		"ears" = COLOR_BLACK,
		"stripe" = COLOR_BLACK
	)

/obj/item/clothing/head/helmet/polymorphic/goblin
	polymorphs = list(
		"base" = COLOR_SILVER,
		"ears" = COLOR_SILVER
	)

/obj/item/clothing/head/helmet/polymorphic/vr
	polymorphs = list(
		"base" = COLOR_GREY_DARK,
		"ears" = COLOR_BLACK,
		"stripe" = COLOR_BLACK
	)
	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50
	)
	value_burgerbux = 1
	value = 400