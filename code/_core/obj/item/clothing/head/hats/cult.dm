/obj/item/clothing/head/hat/cult
	name = "cult hood"
	desc = "MARANAX INFIRMAX"
	desc_extended = "A sinister hood."
	icon = 'icons/obj/item/clothing/hats/cult.dmi'
	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 20,
		HEAT = 20,
		COLD = 20,
		HOLY = -80,
		DARK = 80
	)

	size = SIZE_2

/obj/item/clothing/head/hat/cult/old

	name = "ancient cult hood"
	icon = 'icons/obj/item/clothing/hats/cult_old.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 20,
		HEAT = 20,
		COLD = 20,
		HOLY = -120,
		DARK = 120
	)

	size = SIZE_2