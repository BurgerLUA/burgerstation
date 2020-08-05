//                               Tacticool or slavic armor for hardened ruskies. Thank you stalkerbuild and Parrot very cool.
/obj/item/clothing/overwear/armor/slavticool
	name = "\improper 'Slav-safe' LLC body armor"
	icon = 'icons/obj/item/clothing/suit/squad_armor.dmi'
	desc = "Protecting against the capitalism since 2238."
	desc_extended = "A sturdy chestplate with shoulder- and knee pads of bulletproof armor. Should protect against most small arms fire. Feels lighter than standard-issued vests."

	protected_limbs = list(BODY_TORSO,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 30,
		BLUNT = 30,
		PIERCE = 50,
		LASER = 50,
		ARCANE = -50,
		BOMB = 25
	)

	size = SIZE_3


	value = 300

	slowdown_mul_worn = 1.2

/obj/item/clothing/head/helmet/security/slavticool
	name = "\improper 'Slav-safe' LLC combat helmet"
	icon = 'icons/obj/item/clothing/hats/squad_helmet.dmi'
	desc = "Protecting against the capitalism since 2238."
	desc_extended = "Durable combat helmet made out of complex plastic-based bullet-resistant materials and ceramics. Should save you from a bullet or five."

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 30,
		BLUNT = 30,
		PIERCE = 30,
		LASER = 25,
		ARCANE = -25,
		BOMB = 25
	)

	size = SIZE_2

	value = 150

	slowdown_mul_worn = 1.05

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

	slowdown_mul_worn = 1.4 // (Balanced) Design flaws. :P

	value = 750 //Extraordinary cost. :P

/obj/item/clothing/head/helmet/hardsuit/exosuit
	name = "russian exosuit helmet"
	icon = 'icons/obj/item/clothing/hats/exosuit_helmet.dmi'
	desc = "Duty more like dooty."
	desc_extended = "So, it's an exosuit's helmet. It protects. It is cool, because gas masks are cool."
	rarity = RARITY_RARE

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

	size = SIZE_4


	value = 400