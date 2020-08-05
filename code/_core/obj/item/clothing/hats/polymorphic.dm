/obj/item/clothing/head/helmet/polymorphic
	name = "protective helmet"
	icon = 'icons/obj/item/clothing/hats/security_new.dmi'
	desc = "RUSH B"
	desc_extended = "Standard-issue of the Nanotrasen security force. Protects your head from bullets."

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -25,
		BOMB = 25
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

	slowdown_mul_worn = 1.05

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