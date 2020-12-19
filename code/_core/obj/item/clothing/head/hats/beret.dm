/obj/item/clothing/head/hat/beret
	name = "beret"
	icon = 'icons/obj/item/clothing/hats/beret.dmi'
	desc = "HON HON HON"
	desc_extended = "A fashionable beret."

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = AP_SWORD,
		COLD = AP_DAGGER
	)

	size = SIZE_2


	value = 10

	dyeable = TRUE

/obj/item/clothing/head/hat/beret/shaleez
	color = COLOR_CRIMSON

/obj/item/clothing/head/hat/beret/armored
	name = "armored beret"
	desc_extended = "A fashionable beret with extra padding and protection built into it."
	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		COLD = AP_SWORD
	)
	rarity = RARITY_RARE
	value = 200

/obj/item/clothing/head/hat/beret/armored/syndicate
	color = COLOR_CRIMSON

/obj/item/clothing/head/hat/beret/black
	color = COLOR_BLACK

/obj/item/clothing/head/hat/beret/nanotrasen
	color = COLOR_NANOTRASEN

/obj/item/clothing/head/hat/beret/science
	color = COLOR_SCIENCE