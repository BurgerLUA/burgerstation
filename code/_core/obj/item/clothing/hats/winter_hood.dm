/obj/item/clothing/head/hood/winter
	name = "winter hood"
	desc = "Protects your head against the elements."
	desc_extended = "Click this or shift-click the winter coat to bring the hood back down."
	icon = 'icons/obj/item/clothing/hats/winter_hood.dmi'

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		LASER = -25,
		ARCANE = 50,
		HEAT = -25,
		COLD = 75
	)

	protection_cold = list(
		BODY_HEAD = 5,
	)

	size = SIZE_2


	value = 30


/obj/item/clothing/head/hood/hoodie
	name = "hoodie hood"
	desc = "Where da hood at? Dere da hood at."
	desc_extended = "Click this or shift-click the hoodie to bring the hood back down."
	icon = 'icons/obj/item/clothing/hats/hoodie.dmi'

	size = SIZE_2


	dyeable = FALSE

	value = 10

	defense_rating = list(
		ARCANE = 25,
		HEAT = -25,
		COLD = 50
	)

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)