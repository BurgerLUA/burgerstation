/obj/item/clothing/head/helmet/full/swat
	name = "swat helmet"
	icon = 'icons/obj/item/clothing/hats/swat.dmi'
	desc = "Special Weapons and Teammates."
	desc_extended = "A helmet made from hardened carbon fibres."

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_AXE,
		ARCANE = -AP_AXE,
		HEAT = AP_SWORD,
		COLD = AP_SWORD,
		BOMB = AP_SWORD,
		BIO = AP_SWORD,
		RAD = AP_SWORD,
		PAIN = AP_CLUB
	)

	size = SIZE_3

	value = 500

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE
	)