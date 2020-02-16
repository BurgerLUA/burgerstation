/obj/item/clothing/head/hat/beaver
	name = "beaver hat"
	icon = 'icons/obj/items/clothing/hats/beaver.dmi'
	desc = "Poor people wear these."
	desc_extended = "It's a hat."

	defense_rating = list(
		MAGIC = ARMOR_C,
		COLD = ARMOR_C
	)

	size = SIZE_2
	weight = WEIGHT_1

	value = 5

/obj/item/clothing/head/hat/wizard
	name = "wizard hat"
	icon = 'icons/obj/items/clothing/hats/wizard.dmi'
	desc = "Roll for style."
	desc_extended = "A typical hat worn often by manchildren and those in the wizard federation."
	rarity = RARITY_RARE

	defense_rating = list(
		MAGIC = ARMOR_B,
		DARK = ARMOR_A
	)

	size = SIZE_2
	weight = WEIGHT_1

	value = 20

/obj/item/clothing/head/hat/wizard/blue
	color = "#0065FF"

	defense_rating = list(
		MAGIC = ARMOR_A,
		HOLY = ARMOR_C,
		DARK = ARMOR_C
	)

/obj/item/clothing/head/hat/wizard/red
	color = "#FF0000"

	defense_rating = list(
		MAGIC = ARMOR_A,
		HOLY = ARMOR_C,
		DARK = ARMOR_C
	)