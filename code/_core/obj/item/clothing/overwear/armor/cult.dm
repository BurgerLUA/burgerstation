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
		LASER = -25,
		MAGIC = 25,
		HEAT = 25,
		COLD = 25,
		HOLY = -50,
		DARK = 50
	)

	size = SIZE_4
	weight = WEIGHT_4

	value = 200

/obj/item/clothing/overwear/armor/cult/old
	name = "ancient cult robes"
	desc = "Listen to your eldritch, son."
	desc_extended = "A set of dusty old robes, often worn by elder members of the cult. Dusty, but full of unholy magic."
	icon = 'icons/obj/item/clothing/suit/cult_old.dmi'

	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 25,
		BLUNT = 10,
		PIERCE = 15,
		LASER = -75,
		MAGIC = -25,
		HEAT = 10,
		COLD = 25,
		HOLY = -75
	)

	size = SIZE_3
	weight = WEIGHT_3

	value = 300

/obj/item/clothing/overwear/armor/cult/hard
	name = "hardened cult robes"
	desc = "Try to exorcise me now, dickhead!"
	desc_extended = "A set of heavily padded robes. Has stronger protection than the other robes."
	icon = 'icons/obj/item/clothing/suit/cult_hard.dmi'

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -75,
		MAGIC = -75,
		HEAT = 50,
		COLD = 50,
		HOLY = -25,
	)

	size = SIZE_5
	weight = WEIGHT_5

	value = 300