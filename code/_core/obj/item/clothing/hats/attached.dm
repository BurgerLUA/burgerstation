/obj/item/clothing/head/helmet/explorer_suit
	name = "explorer suit helmet"
	icon = 'icons/obj/item/clothing/hats/explorer_suit.dmi'
	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 25,
		ARCANE = 25,
		HEAT = 50,
		COLD = 25,
		BIO = 25,
		HOLY = 25,
		DARK = 25,
	)

	size = SIZE_3

	value = 300

	slowdown_mul_worn = 1.05

/obj/item/clothing/head/hood/goliath_cloak
	name = "goliath cloak hood"
	icon = 'icons/obj/item/clothing/hats/goliath_cloak.dmi'
	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 50,
		ARCANE = 50,
		HEAT = 50,
		COLD = 25,
		HOLY = 50,
		DARK = 50
	)

	size = SIZE_3


	value = 300

	dyeable = FALSE

/obj/item/clothing/head/helmet/drake
	name = "ash drake helmet"
	icon = 'icons/obj/item/clothing/hats/drake_helmet.dmi'
	rarity = RARITY_MYTHICAL

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 75,
		ARCANE = 25,
		HEAT = 50,
		COLD = -25,
		HOLY = -25,
		DARK = 50
	)

	size = SIZE_3


	value = 400

	slowdown_mul_worn = 1.1