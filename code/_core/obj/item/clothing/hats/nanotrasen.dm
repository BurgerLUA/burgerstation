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
		LASER = 25,
		ARCANE = -100,
		HEAT = 50,
		COLD = 50,
		BOMB = 25
	)

	value = 800

	slowdown_mul_worn = 1.10

/obj/item/clothing/head/helmet/nanotrasen/medium
	name = "medium Jaeger hemlet"
	polymorphs = list(
		"helmet_medium" = "#FFFFFF",
		"visor_medium" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 50,
		ARCANE = -125,
		HEAT = 50,
		COLD = 50,
		BOMB = 50
	)

	value = 1300

	slowdown_mul_worn = 1.25

/obj/item/clothing/head/helmet/nanotrasen/heavy
	name = "heavy Jaeger hemlet"
	polymorphs = list(
		"helmet_heavy" = "#FFFFFF",
		"visor_heavy" = "#FFFFFF"
	)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 100,
		PIERCE = 100,
		LASER = 50,
		ARCANE = -200,
		HEAT = 50,
		COLD = 50,
		BOMB = 100
	)

	value = 2700

	slowdown_mul_worn = 1.35