/obj/item/clothing/head/helmet/full/space_military
	name = "space military helmet"
	icon = 'icons/obj/item/clothing/hats/space_military.dmi'
	desc = "Military. In space!"
	desc_extended = "A helmet made from hardened carbon fibres."

	defense_rating = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		ARCANE = -75,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 50,
		RAD = 50
	)

	size = SIZE_3

	value = 500

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)