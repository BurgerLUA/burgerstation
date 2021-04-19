/obj/item/clothing/overwear/armor/cult
	name = "cult robes"
	desc = "We all have to start somewhere. Even if you're joining a blood cult."
	desc_extended = "A set of robes often worn by the low-ranking acolytes of the cult of Nar-sie. Has no supernatural qualities, but it's padded."
	icon = 'icons/obj/item/clothing/suit/cult.dmi'
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 20,
		HEAT = 20,
		COLD = 20,
		HOLY = -80,
		DARK = 80,
		PAIN = 40
	)

	size = SIZE_4


	value = 200

	additional_clothing = list(
		/obj/item/clothing/head/hat/cult
	)

/obj/item/clothing/overwear/armor/cult/old
	name = "ancient cult robes"
	desc = "Listen to your eldritch, son."
	desc_extended = "A set of dusty old robes, often worn by elder members of the cult. Dusty, but full of unholy magic."
	icon = 'icons/obj/item/clothing/suit/cult_old.dmi'

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

	size = SIZE_3

	value = 300

	additional_clothing = list(
		/obj/item/clothing/head/hat/cult/old
	)

/obj/item/clothing/overwear/armor/cult/hard
	name = "hardened cult robes"
	desc = "Try to exorcise me now, dickhead!"
	desc_extended = "A set of heavily padded robes. Has stronger protection than the other robes."
	icon = 'icons/obj/item/clothing/suit/cult_hard.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = -40,
		ARCANE = 20,
		HEAT = 40,
		COLD = 40,
		HOLY = -60,
		DARK = 60
	)

	size = SIZE_5


	value = 500

	additional_clothing = list(
		/obj/item/clothing/head/helmet/hardsuit/cult
	)