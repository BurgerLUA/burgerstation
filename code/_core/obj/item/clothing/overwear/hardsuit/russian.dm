/obj/item/clothing/overwear/hardsuit/exosuit
	name = "Russian exosuit"
	icon = 'icons/obj/item/clothing/suit/exosuit.dmi'
	desc = "RIP Tachenko."
	desc_extended = "An experimental sample of a military exoskeleton. Was never mass-produced due to extraordinary cost and some design flaws. Despite this, it is in demand due to its ability to take on the weight of all carried equipment, and therefore small batches are made in underground facilities."
	rarity = RARITY_UNCOMMON

	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	defense_rating = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 50,
		LASER = 50,
		ARCANE = -100,
		HEAT = 50,
		COLD = 50,
		BOMB = 50
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/exosuit)

	value = 750 //Extraordinary cost. :P


/obj/item/clothing/overwear/hardsuit/skat
	name = "SKAT-9"
	icon = 'icons/obj/item/clothing/suit/skat.dmi'
	desc = "RIP Stingray."
	desc_extended = "This modern military armored suit is designed for assault operations in anomalous areas. Comprises a PSZ-12p heavy military armored suit, built-in compensation suit, and an anomalous protection bodysuit. The armor provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer's mobility. Does not come with an artifact container, as there's literally no artifacts anywhere. You know, different universe."
	rarity = RARITY_UNCOMMON

	item_slot = SLOT_TORSO_A | SLOT_TORSO_O
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	defense_rating = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 100,
		LASER = 75,
		ARCANE = -250,
		HEAT = 50,
		COLD = 50,
		BOMB = 75
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/skat)

	value = 1050