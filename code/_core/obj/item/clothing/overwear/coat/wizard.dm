/obj/item/clothing/overwear/coat/wizard
	name = "wizard's robes"
	icon = 'icons/obj/item/clothing/suit/wizard.dmi'

	desc = "EI NATH!!"
	desc_extended = "Not necessairly required to use magic, but wearing this, or any other clothing with high Magic protection will make your spells stronger."

	defense_rating = list(
		ARCANE = 80,
		DARK = -40,
		HOLY = -40
	)

	size = SIZE_3

	value = 120

	dyeable = TRUE

/obj/item/clothing/overwear/coat/wizard/red
	color = "#FF0000"

/obj/item/clothing/overwear/coat/wizard/blue
	color = "#0065FF"

/obj/item/clothing/overwear/coat/wizard/purple
	name = "authentic wizard robes"
	desc = "The real deal."
	rarity = RARITY_MYTHICAL
	desc_extended = "A real, totally authentic wizard robes with all the protection a wizard needs."
	color = COLOR_PURPLE
	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		ARCANE = 80,
		DARK = -40,
		HOLY = -40
	)