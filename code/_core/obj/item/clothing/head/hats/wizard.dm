/obj/item/clothing/head/hat/wizard
	name = "wizard hat"
	icon = 'icons/obj/item/clothing/hats/wizard.dmi'
	desc = "Roll for style."
	desc_extended = "A typical hat worn often by manchildren and those in the wizard federation."
	rarity = RARITY_RARE

	defense_rating = list(
		ARCANE = 80,
		DARK = -40,
		HOLY = -40
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

/obj/item/clothing/head/hat/wizard/purple
	name = "authentic wizard hat"
	desc = "The real deal."
	rarity = RARITY_MYTHICAL
	desc_extended = "A real, totally authentic wizard hat with all the protection a wizard needs."
	color = COLOR_PURPLE
	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		ARCANE = 80,
		DARK = -40,
		HOLY = -40
	)