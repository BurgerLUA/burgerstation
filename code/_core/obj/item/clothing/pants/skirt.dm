/obj/item/clothing/pants/skirt
	name = "skirt"
	icon = 'icons/obj/items/clothing/pants/skirt.dmi'

	desc = "For letting people know that you're female. Or a crossdresser."
	desc_extended = "The peak of fashion."

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 10,
		MAGIC = 25,
		HEAT = 15,
		COLD = 25
	)

	dyeable = TRUE

	polymorphs = list(
		"skirt" = COLOR_WHITE
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 10

/obj/item/clothing/pants/skirt/striped
	name = "striped skirt"
	polymorphs = list(
		"skirt" = COLOR_WHITE,
		"stripes" = COLOR_BLACK
	)

/obj/item/clothing/pants/skirt/grey
	name = "assistant skirt"
	polymorphs = list(
		"skirt" = COLOR_GREY
	)
