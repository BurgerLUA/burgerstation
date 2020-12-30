/obj/item/clothing/overwear/hardsuit/mining
	name = "mining hardsuit"
	desc = "MIIIIINIIIIING DIAAAAMOOOOOONDS!"
	desc_extended = "A hardsuit worn by miners to protect against a variety of hazards, such as rock falls, black lungs, and cave monsters."
	icon = 'icons/obj/item/clothing/suit/hardsuit_mining.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = -AP_GREATSWORD,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		BOMB = AP_AXE,
		BIO = AP_SWORD,
		RAD = AP_SWORD
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/mining)

	value = 1000

	loyalty_tag = "NanoTrasen"