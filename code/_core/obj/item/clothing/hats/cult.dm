/obj/item/clothing/head/hood/cult
	name = "cult hood"
	desc = "MARANAX INFIRMAX"
	desc_extended = "A sinister hood that for some reason doesn't work as an actual toggle-able hood."
	icon = 'icons/obj/item/clothing/hats/cult.dmi'
	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -10,
		ARCANE = 25,
		HEAT = 25,
		COLD = 25,
		HOLY = -50,
		DARK = 50
	)

	size = SIZE_2


	value = 120

/obj/item/clothing/head/hood/cult/old

	name = "ancient cult hood"
	icon = 'icons/obj/item/clothing/hats/cult_old.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		ARCANE = 50,
		HEAT = 50,
		COLD = 25,
		HOLY = -75,
		DARK = 75
	)

	size = SIZE_2


	value = 200

/obj/item/clothing/head/helmet/cult

	name = "hardened cult hood"
	icon = 'icons/obj/item/clothing/hats/cult_hard.dmi'
	rarity = RARITY_MYTHICAL

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 75,
		LASER = -75,
		ARCANE = 25,
		HEAT = 50,
		COLD = 50,
		HOLY = -75,
		DARK = 100
	)

	size = SIZE_3

	value = 40

	slowdown_mul_worn = 1.05



