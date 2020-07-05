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
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		LASER = -10,
		MAGIC = 25,
		HEAT = 25,
		COLD = 25,
		HOLY = -50,
		DARK = 50
	)

	size = SIZE_2
	weight = WEIGHT_2

	value = 20

/obj/item/clothing/head/hood/cult/old

	name = "ancient cult hood"
	icon = 'icons/obj/item/clothing/hats/cult_old.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 50,
		HEAT = 50,
		COLD = 25,
		HOLY = -75,
		DARK = 75
	)

	size = SIZE_2
	weight = WEIGHT_1

	value = 100

/obj/item/clothing/head/helmet/cult

	name = "hardened cult hood"
	icon = 'icons/obj/item/clothing/hats/cult_hard.dmi'
	rarity = RARITY_MYTHICAL

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 50,
		LASER = -75,
		MAGIC = 25,
		HEAT = 50,
		COLD = 50,
		HOLY = -75,
		DARK = 100
	)

	size = SIZE_3
	weight = WEIGHT_3

	value = 40



