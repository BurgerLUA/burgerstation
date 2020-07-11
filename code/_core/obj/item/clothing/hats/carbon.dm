/obj/item/clothing/head/helmet/carbon
	name = "space military helmet"
	icon = 'icons/obj/item/clothing/hats/carbon.dmi'
	desc = "RUSH B"
	desc_extended = "A sturdy tactical helmet. Protects your head from bullets."

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -25,
		BOMB = 25
	)

	size = SIZE_3


	value = 200

	polymorphs = list(
		"visor" = "#FFFFFF",
		"helmet" = "#FFFFFF"
	)

	no_initial_blend = TRUE

	dyeable = TRUE

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE

	slowdown_mul_worn = 1.05


/obj/item/clothing/head/helmet/carbon/nanotrasen
	polymorphs = list(
		"visor" = COLOR_GOLD,
		"helmet" = COLOR_NANOTRASEN
	)


/obj/item/clothing/head/helmet/carbon/dummy
	name = "old space swat helmet"
	polymorphs = list(
		"visor" = COLOR_BROWN,
		"helmet" = COLOR_RED
	)