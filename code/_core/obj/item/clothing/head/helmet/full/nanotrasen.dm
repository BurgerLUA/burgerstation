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

	armor = /armor/military/light/hard

	value = 200

/obj/item/clothing/head/helmet/full/nanotrasen/light/deathsquad
	polymorphs = list(
		"helmet_light" = COLOR_DEATHSQUAD_BLACK,
		"visor_light" = COLOR_DEATHSQUAD_RED
	)


/obj/item/clothing/head/helmet/full/nanotrasen/medium
	name = "medium Jaeger helmet"
	polymorphs = list(
		"helmet_medium" = "#FFFFFF",
		"visor_medium" = "#FFFFFF"
	)

	armor = /armor/military/medium/hard

	value = 300

/obj/item/clothing/head/helmet/full/nanotrasen/medium/deathsquad
	polymorphs = list(
		"helmet_medium" = COLOR_DEATHSQUAD_BLACK,
		"visor_medium" = COLOR_DEATHSQUAD_RED
	)


/obj/item/clothing/head/helmet/full/nanotrasen/heavy
	name = "heavy Jaeger helmet"
	polymorphs = list(
		"helmet_heavy" = "#FFFFFF",
		"visor_heavy" = "#FFFFFF"
	)

	armor = /armor/military/heavy/hard

	value = 400

/obj/item/clothing/head/helmet/full/nanotrasen/heavy/deathsquad
	polymorphs = list(
		"helmet_heavy" = COLOR_DEATHSQUAD_BLACK,
		"visor_heavy" = COLOR_DEATHSQUAD_RED
	)