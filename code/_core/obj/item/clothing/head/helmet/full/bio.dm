/obj/item/clothing/head/helmet/full/bio
	name = "bio helmet"
	desc = "For biological hazards."
	desc_extended = "The top part of a full body biohazard suit. Good for protecting yourself from the biohazards."
	icon = 'icons/obj/item/clothing/hats/bio.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		ARCANE = -50,
		HEAT = 50,
		COLD = 50,
		BIO = 200
	)

	size = SIZE_3


/obj/item/clothing/head/helmet/full/rad
	name = "radiation helmet"
	desc = "For radioactive hazards."
	desc_extended = "The top part of a full body radiation suit. Good for protecting yourself from the rads."
	icon = 'icons/obj/item/clothing/hats/rad.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		ARCANE = -50,
		HEAT = 50,
		COLD = 50,
		BIO = 100,
		RAD = 200
	)

	size = SIZE_3


/obj/item/clothing/head/helmet/full/bomb
	name = "bomb helmet"
	desc = "For explosive hazards."
	desc_extended = "The top part of a full body bomb suit. Good for protecting yourself from the bombs."
	icon = 'icons/obj/item/clothing/hats/rad.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLUNT = 50,
		ARCANE = -50,
		HEAT = 25,
		COLD = 25,
		BOMB = 200
	)

	size = SIZE_3