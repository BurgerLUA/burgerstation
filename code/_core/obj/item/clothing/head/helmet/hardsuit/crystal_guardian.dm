/obj/item/clothing/head/helmet/hardsuit/crystal_guardian
	name = "crystal guardian's helmet"
	desc = "A helmet forged with crystals and enchanted alloy that's used by the mystical Crystal Guardians."
	desc_extended = "Little is known about the origin of Crystal Guardians, their attunement towards crystal based magic is unparalelled and in turn is utilized in all of their equipment."
	icon = 'icons/obj/item/clothing/hats/crystal_guardian.dmi'
	rarity = RARITY_MYTHICAL
	value_burgerbux = 1 //to keep it from spawning without the hardsuit

	defense_rating = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 20,
		LASER = -60,
		ARCANE = 120,
		HEAT = -60,
		COLD = 60,
		BOMB = 40,
		BIO = 20,
		RAD = 20
	)

	size = SIZE_3