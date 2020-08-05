/obj/item/clothing/glasses/sun
	name = "sunglasses"
	rarity = RARITY_UNCOMMON
	desc = "Deal with it."
	desc_extended = "A simple pair of sleek sunglasses designed to reflect sunlight, and lasers. The inverse of prescription glasses."
	icon = 'icons/obj/item/clothing/glasses/sunglasses.dmi'

	defense_rating = list(
		BLADE = 5,
		BLUNT = 5,
		PIERCE = 5,
		LASER = 50,
		ARCANE = -25,
		HEAT = 25
	)

	value = 30


/obj/item/clothing/glasses/sun/augmented
	name = "augmented shades"
	desc = "Your vision is augmented."
	desc_extended = "Powerful augmented shades meant for security personel. These come with a built in security HUD as well as thermal imaging. For the badass."
	icon = 'icons/obj/item/clothing/glasses/abomb_shades.dmi'
	rarity = RARITY_MYTHICAL
	defense_rating = list(
		BLADE = 15,
		BLUNT = 15,
		PIERCE = 15,
		LASER = 50,
		ARCANE = -50,
		BOMB = -25
	)

	sight_mod = SEE_MOBS
	vision_mod = FLAG_VISION_SECURITY | FLAG_VISION_MEDICAL

	value = 1400