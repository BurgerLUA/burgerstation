/obj/item/clothing/overwear/coat/sorcerer
	name = "sorcerer's cloak"
	icon = 'icons/obj/item/clothing/suit/sorcerer_cloak.dmi'

	desc = "A sorcerer's cloak. Frequently dyed to show one's proficiency in a specific magical art."
	desc_extended = "Sorcerers commonly dye their garments based on the primary house of magic they were a part of during their schooling. The quality and upkeep of a sorcerer's robes are of high priority to a sorcerer. Those who neglect upkeep quickly find themselves with the ire of their peers."

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_TORSO = TRUE
	)

	defense_rating = list(
		ARCANE = 100,
		COLD = 25,
		HEAT = 15,
		HOLY = -75,
		DARK = 100
	)

	rarity = RARITY_RARE

	size = SIZE_3

	value = 1200

	dyeable = TRUE

	additional_clothing = list(
		/obj/item/clothing/head/hood/sorcerer_hood,
		/obj/item/clothing/neck/sorcerer
	)