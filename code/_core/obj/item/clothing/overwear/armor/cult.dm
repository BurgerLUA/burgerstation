/obj/item/clothing/overwear/armor/cult
	name = "cult robes"
	desc = "We all have to start somewhere. Even if you're joining a blood cult."
	desc_extended = "A set of robes often worn by the low-ranking acolytes of the cult of Nar-sie. Has no supernatural qualities, but it's padded."
	icon = 'icons/obj/item/clothing/suit/cult.dmi'
	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	rarity = RARITY_UNCOMMON

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

	size = SIZE_4


	value = 200

	slowdown_mul_worn = 1.1

/obj/item/clothing/overwear/armor/cult/old
	name = "ancient cult robes"
	desc = "Listen to your eldritch, son."
	desc_extended = "A set of dusty old robes, often worn by elder members of the cult. Dusty, but full of unholy magic."
	icon = 'icons/obj/item/clothing/suit/cult_old.dmi'

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

	size = SIZE_3


	value = 300

/obj/item/clothing/overwear/armor/cult/hard
	name = "hardened cult robes"
	desc = "Try to exorcise me now, dickhead!"
	desc_extended = "A set of heavily padded robes. Has stronger protection than the other robes."
	icon = 'icons/obj/item/clothing/suit/cult_hard.dmi'

	rarity = RARITY_MYTHICAL

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

	size = SIZE_5


	value = 500

	additional_clothing = list(/obj/item/clothing/head/helmet/cult)

	slowdown_mul_worn = 1.2