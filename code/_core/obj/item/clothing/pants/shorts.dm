/obj/item/clothing/pants/shorts
	name = "shorts"
	icon = 'icons/obj/item/clothing/pants/shorts.dmi'

	desc = "Eat Pant."
	desc_extended = "The peak of fashion."

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		ARCANE = 20,
		HEAT = 10
	)

	dyeable = TRUE

	polymorphs = list(
		"pants" = COLOR_WHITE
	)

	size = SIZE_2


	value = 10


/obj/item/clothing/pants/shorts/red_soccer
	name = "red soccer shorts"
	polymorphs = list(
		"pants" = COLOR_RED,
		"stripes" = COLOR_WHITE
	)

/obj/item/clothing/pants/shorts/blue_soccer
	name = "blue soccer shorts"
	polymorphs = list(
		"pants" = COLOR_BLUE,
		"stripes" = COLOR_BLACK
	)

/obj/item/clothing/pants/shorts/ref_soccer
	name = "blue soccer shorts"
	polymorphs = list(
		"pants" = COLOR_BLACK
	)