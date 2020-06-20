/obj/item/clothing/pants/normal
	name = "pants"
	icon = 'icons/obj/items/clothing/pants/normal.dmi'

	desc = "Please wear these at least."
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
		"pants" = COLOR_WHITE
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 10


/obj/item/clothing/pants/normal/striped
	name = "striped pants"
	polymorphs = list(
		"pants" = COLOR_BLACK,
		"stripes" = COLOR_WHITE
	)

/obj/item/clothing/pants/normal/chaps
	name = "chapped pants"
	polymorphs = list(
		"pants" = COLOR_WHITE,
		"chaps" = COLOR_BLACK
	)

/obj/item/clothing/pants/normal/chaps/assless
	name = "assless chaps"
	polymorphs = list(
		"chaps" = COLOR_WHITE
	)

/obj/item/clothing/pants/normal/security
	name = "security pants"
	polymorphs = list(
		"pants" = COLOR_SECURITY_DARK
	)

/obj/item/clothing/pants/normal/engineering
	name = "security pants"
	polymorphs = list(
		"pants" = COLOR_ENGINEERING,
		"stripes" = COLOR_VISIBLE_GREEN
	)

/obj/item/clothing/pants/normal/medical
	name = "medical pants"
	polymorphs = list(
		"pants" = COLOR_MEDICAL_LIGHT
	)

/obj/item/clothing/pants/normal/grey
	name = "assistant pants"
	polymorphs = list(
		"pants" = COLOR_GREY
	)