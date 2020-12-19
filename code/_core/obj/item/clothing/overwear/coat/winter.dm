/obj/item/clothing/overwear/coat/winter
	name = "winter coat"
	desc = "Ice climber."
	desc_extended = "Protects against the cold, but leaves you vurnerable to heat."
	icon = 'icons/obj/item/clothing/suit/winter_coat.dmi'

	defense_rating = list(
		LASER = -AP_AXE,
		ARCANE = AP_AXE,
		HEAT = -AP_AXE,
		COLD = AP_GREATSWORD
	)

	protection_cold = list(
		BODY_TORSO = 5,
		BODY_ARM_LEFT = 4,
		BODY_ARM_RIGHT = 4,
		BODY_GROIN = 2
	)

	additional_clothing = list(/obj/item/clothing/head/hat/winter)

	size = SIZE_3


	value = 20

/obj/item/clothing/overwear/coat/winter/bomber
	name = "bomber jacket"
	desc = "Sleek and clean, the death machines stand ready on their decks."
	desc_extended = "Wait this actually protects agains bombs. What the fuck, Burger."
	icon = 'icons/obj/item/clothing/suit/bomberjacket.dmi'
	additional_clothing = list() // no hood

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 15,
		BLUNT = 10,
		PIERCE = 10,
		LASER = -25,
		ARCANE = 50,
		HEAT = -25,
		COLD = 75,
		BOMB = 25
	)

	size = SIZE_3

	value = 120