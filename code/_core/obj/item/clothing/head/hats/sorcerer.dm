/obj/item/clothing/head/hat/sorcerer_hood
	name = "sorcerer's hood"
	desc = "A sorcerer's hood. Frequently dyed to show one's proficiency in a specific magical art."
	desc_extended = "Click this or shift-click the cloak to bring the hood back down."
	icon = 'icons/obj/item/clothing/hats/sorcerer_hood.dmi'

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		ARCANE = 80,
		COLD = 20,
		HOLY = -40,
		DARK = 40
	)

	rarity = RARITY_RARE

	size = SIZE_2


	value = 120

	dyeable = TRUE
