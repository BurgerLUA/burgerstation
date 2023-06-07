/obj/item/clothing/head/helmet/polymorphic
	name = "protective helmet"
	icon = 'icons/obj/item/clothing/hats/security_new.dmi'
	desc = "RUSH B"
	desc_extended = "Standard-issue of the Nanotrasen security force. Protects your head from bullets."

	armor = /armor/military/light/hard

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

/obj/item/clothing/head/helmet/polymorphic/janitor
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ears" = COLOR_NANOTRASEN,
		"stripe" = COLOR_JANITOR
	)

/obj/item/clothing/head/helmet/polymorphic/science
	polymorphs = list(
		"base" = COLOR_WHITE,
		"ears" = COLOR_NANOTRASEN,
		"stripe" = COLOR_SCIENCE
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
		"stripe" = COLOR_VISIBLE_GREEN
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
	armor = /armor/military/medium/hard

/obj/item/clothing/head/helmet/polymorphic/reinforced/black
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ears" = COLOR_GREY_DARK,
		"stripe" = COLOR_BLACK
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
	armor = /armor/military/medium/hard
	value_burgerbux = 1
	value = 400