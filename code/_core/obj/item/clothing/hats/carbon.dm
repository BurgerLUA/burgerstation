/obj/item/clothing/head/helmet/carbon
	name = "heavy protective helmet"
	icon = 'icons/obj/item/clothing/hats/carbon.dmi'
	desc = "RUSH B"
	desc_extended = "A sturdy tactical helmet. Protects your head from bullets."

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		ARCANE = -25,
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

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE | SLOT_EYES

	slowdown_mul_worn = 1.05

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)

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