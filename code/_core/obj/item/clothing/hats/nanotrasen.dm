/obj/item/clothing/head/helmet/nanotrasen
	name = "nanotrasen helmet"
	desc = "Futuristic!"
	desc_extended = "A suit of extremely expensive Jaeger prototype armor made by Space Germany. Offers the best protection possible."
	icon = 'icons/obj/item/clothing/hats/helmet_modular.dmi'

	dyeable = TRUE

/obj/item/clothing/head/helmet/nanotrasen/light
	name = "light Jaeger helmet"
	polymorphs = list(
		"helmet_light" = "#FFFFFF",
		"visor_light" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 75,
		ARCANE = -75,
		BOMB = 75
	)

	value = 200

	slowdown_mul_worn = 1

/obj/item/clothing/head/helmet/nanotrasen/light/deathsquad
	polymorphs = list(
		"helmet_light" = COLOR_BLACK,
		"visor_light" = COLOR_RED
	)


/obj/item/clothing/head/helmet/nanotrasen/medium
	name = "medium Jaeger hemlet"
	polymorphs = list(
		"helmet_medium" = "#FFFFFF",
		"visor_medium" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		ARCANE = -75,
		BOMB = 75
	)

	value = 300

	slowdown_mul_worn = 1.05

/obj/item/clothing/head/helmet/nanotrasen/medium/deathsquad
	polymorphs = list(
		"helmet_medium" = COLOR_BLACK,
		"visor_medium" = COLOR_RED
	)


/obj/item/clothing/head/helmet/nanotrasen/heavy
	name = "heavy Jaeger hemlet"
	polymorphs = list(
		"helmet_heavy" = "#FFFFFF",
		"visor_heavy" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		ARCANE = -100,
		BOMB = 200
	)

	value = 400

	slowdown_mul_worn = 1.15

/obj/item/clothing/head/helmet/nanotrasen/heavy/deathsquad
	polymorphs = list(
		"helmet_heavy" = COLOR_BLACK,
		"visor_heavy" = COLOR_RED
	)