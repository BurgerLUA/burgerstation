/obj/item/clothing/head/hat/beaver
	name = "beaver hat"
	icon = 'icons/obj/item/clothing/hats/beaver.dmi'
	desc = "Poor people wear these."
	desc_extended = "It's a hat made out of an innocent beaver. It was a vain sacrifice on it's part, since it's ugly as shit."

	defense_rating = list(
		ARCANE = 25,
		COLD = 25
	)

	size = SIZE_2


	value = 10

/obj/item/clothing/head/hat/wizard
	name = "wizard hat"
	icon = 'icons/obj/item/clothing/hats/wizard.dmi'
	desc = "Roll for style."
	desc_extended = "A typical hat worn often by manchildren and those in the wizard federation."
	rarity = RARITY_RARE

	defense_rating = list(
		ARCANE = 75,
		DARK = -25,
		HOLY = -25
	)

	size = SIZE_2

	value = 120

	dyeable = TRUE

/obj/item/clothing/head/hat/wizard/gold
	color = COLOR_GOLD

/obj/item/clothing/head/hat/wizard/blue
	color = "#0065FF"

/obj/item/clothing/head/hat/wizard/red
	color = "#FF0000"