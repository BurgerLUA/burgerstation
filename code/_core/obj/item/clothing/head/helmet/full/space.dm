/obj/item/clothing/head/helmet/full/space
	name = "space helmet"
	desc = "Helmets... in space!"
	desc_extended = "A very sturdy old space helmet. Built in is a system that regulates heating and cooling of the body."
	icon = 'icons/obj/item/clothing/hats/space_old.dmi'
	rarity = RARITY_UNCOMMON

	hidden_organs = list(
		BODY_HAIR_HEAD = TRUE
	)

	defense_rating = list(
		BLADE = 30,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -50,
		HEAT = 100,
		COLD = 100,
		BIO = 100
	)

	size = SIZE_3