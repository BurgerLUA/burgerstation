/obj/item/clothing/head/helmet/full/space_military
	name = "space military helmet"
	icon = 'icons/obj/item/clothing/hats/space_military.dmi'
	desc = "Military. In space!"
	desc_extended = "A helmet made from hardened carbon fibres."

	defense_rating = list(
		BLADE = 20,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -40,
		ARCANE = -40,
		HEAT = 20,
		COLD = 20,
		BOMB = 20,
		BIO = 20,
		RAD = 20,
		PAIN = AP_CLUB
	)

	size = SIZE_3

	value = 500

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)