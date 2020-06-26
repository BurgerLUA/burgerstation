/obj/item/clothing/head/helmet/carbon
	name = "space swat helmet"
	icon = 'icons/obj/items/clothing/hats/carbon.dmi'
	desc = "RUSH B"
	desc_extended = "A sturdy tactical helmet. Protects your head from bullets."

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 25,
		MAGIC = -25,
		BOMB = 25
	)

	size = SIZE_3
	weight = WEIGHT_2

	value = 200

	polymorphs = list(
		"visor" = "#FFFFFF",
		"helmet" = "#FFFFFF"
	)

	no_initial_blend = TRUE

	dyeable = TRUE


/obj/item/clothing/head/helmet/carbon/nanotrasen
	polymorphs = list(
		"visor" = COLOR_GOLD,
		"helmet" = COLOR_NANOTRASEN
	)