/obj/item/clothing/head/hat/hoodie
	name = "hoodie hood"
	desc = "Where da hood at? Dere da hood at."
	desc_extended = "Click this or shift-click the hoodie to bring the hood back down."
	icon = 'icons/obj/item/clothing/hats/hoodie.dmi'

	size = SIZE_2


	dyeable = FALSE

	value = 10

	defense_rating = list(
		ARCANE = AP_SWORD,
		HEAT = -AP_SWORD,
		COLD = AP_CLUB
	)

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)