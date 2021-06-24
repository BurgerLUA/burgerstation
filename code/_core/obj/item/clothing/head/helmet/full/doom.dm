/obj/item/clothing/head/helmet/full/doom
	name = "\improper D.U.U.M. helmet"
	desc = "For badasses who don't like NanoTrasen's colors or something."
	desc_extended = "A military helmet made for military men."
	rarity = RARITY_RARE
	icon = 'icons/obj/item/clothing/hats/doom.dmi'
	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
	)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		ARCANE = -50,
		HEAT = 50,
		BOMB = 50,
		HOLY = 75,
		DARK = 75
	)

	size = SIZE_3