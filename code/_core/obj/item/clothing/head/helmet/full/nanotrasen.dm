/obj/item/clothing/head/helmet/full/nanotrasen
	name = "nanotrasen helmet"
	desc = "Futuristic!"
	desc_extended = "A suit of extremely expensive Jaeger prototype armor made by Space Germany. Offers the best protection possible."
	icon = 'icons/obj/item/clothing/hats/helmet_modular.dmi'

	dyeable = TRUE

/obj/item/clothing/head/helmet/full/nanotrasen/light
	name = "light Jaeger helmet"
	polymorphs = list(
		"helmet_light" = "#FFFFFF",
		"visor_light" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_AXE,
		ARCANE = -AP_AXE,
		BOMB = AP_AXE
	)

	value = 200

/obj/item/clothing/head/helmet/full/nanotrasen/light/deathsquad
	polymorphs = list(
		"helmet_light" = COLOR_DEATHSQUAD_BLACK,
		"visor_light" = COLOR_DEATHSQUAD_RED
	)


/obj/item/clothing/head/helmet/full/nanotrasen/medium
	name = "medium Jaeger hemlet"
	polymorphs = list(
		"helmet_medium" = "#FFFFFF",
		"visor_medium" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = -AP_CLUB,
		BOMB = AP_AXE
	)

	value = 300

/obj/item/clothing/head/helmet/full/nanotrasen/medium/deathsquad
	polymorphs = list(
		"helmet_medium" = COLOR_DEATHSQUAD_BLACK,
		"visor_medium" = COLOR_DEATHSQUAD_RED
	)


/obj/item/clothing/head/helmet/full/nanotrasen/heavy
	name = "heavy Jaeger hemlet"
	polymorphs = list(
		"helmet_heavy" = "#FFFFFF",
		"visor_heavy" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = AP_AXE,
		ARCANE = -AP_GREATSWORD,
		BOMB = AP_AXE
	)

	value = 400

/obj/item/clothing/head/helmet/full/nanotrasen/heavy/deathsquad
	polymorphs = list(
		"helmet_heavy" = COLOR_DEATHSQUAD_BLACK,
		"visor_heavy" = COLOR_DEATHSQUAD_RED
	)