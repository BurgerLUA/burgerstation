/obj/item/clothing/head/helmet/polymorphic
	name = "protective helmet"
	icon = 'icons/obj/item/clothing/hats/security_new.dmi'
	desc = "RUSH B"
	desc_extended = "Standard-issue of the Nanotrasen security force. Protects your head from bullets."

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = -AP_AXE,
		BOMB = AP_AXE,
		PAIN = AP_CLUB
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

/obj/item/clothing/head/helmet/polymorphic/security
	polymorphs = list(
		"base" = COLOR_BLACK,
		"ears" = COLOR_SECURITY,
		"stripe" = COLOR_SECURITY
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
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_CLUB,
		LASER = AP_AXE,
		ARCANE = -AP_CLUB,
		BOMB = AP_AXE,
		PAIN = AP_CLUB
	)

/obj/item/clothing/head/helmet/polymorphic/reinforced/ntops
	name = "NT ops reinforced protective helmet"
	polymorphs = list(
		"base" = COLOR_WHITE,
		"ears" = COLOR_BLACK,
		"stripe" = COLOR_BLACK
	)