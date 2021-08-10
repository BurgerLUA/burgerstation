/obj/item/clothing/overwear/hardsuit/mining
	name = "mining hardsuit"
	desc = "MIIIIINIIIIING DIAAAAMOOOOOONDS!"
	desc_extended = "A hardsuit worn by miners to protect against a variety of hazards, such as rock falls, black lungs, and cave monsters."
	icon = 'icons/obj/item/clothing/suit/hardsuit_mining.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = -80,
		HEAT = 60,
		COLD = 60,
		BOMB = 40,
		BIO = 20,
		RAD = 20
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/mining)

	value = 1000

	loyalty_tag = "NanoTrasen"

/obj/item/clothing/overwear/hardsuit/mining/golem
	loyalty_tag = "golem"