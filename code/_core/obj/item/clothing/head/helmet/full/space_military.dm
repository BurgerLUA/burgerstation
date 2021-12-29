/obj/item/clothing/head/helmet/full/space_military
	name = "space military helmet"
	icon = 'icons/obj/item/clothing/hats/space_military_new.dmi'
	desc = "Military. In space!"
	desc_extended = "A helmet made from hardened carbon fibres."

	defense_rating = list(
		BLADE = 20,
		BLUNT = 60,
		PIERCE = 60,
		LASER = -40,
		ARCANE = -40,
		HEAT = 20,
		COLD = 20,
		BOMB = 20,
		BIO = 20,
		RAD = 20,
		PAIN = 60
	)

	size = SIZE_3

	value = 500

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)

	dyeable = TRUE

	polymorphs = list(
		"armor" = "#303030",
		"visor" = "#00137F"
	)