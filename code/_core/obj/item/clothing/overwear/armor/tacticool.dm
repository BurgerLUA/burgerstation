//                               Tacticool or slavic armor for hardened ruskies. Thank you stalkerbuild and Parrot very cool.
/obj/item/clothing/overwear/armor/slavticool
	name = "military body armor set"
	icon = 'icons/obj/items/clothing/suit/squad_armor.dmi'
	item_slot = SLOT_TORSO_A
	desc = "Protecting against the capitalism since 2238."
	desc_extended = "A sturdy chestplate with shoulder- and knee pads of bulletproof armor. Should protect against most small arms fire."

	protected_limbs = list(BODY_TORSO,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 40,
		BLUNT = 60,
		PIERCE = 75,
		LASER = 65,
		MAGIC = -75,
		HEAT = 40,
		COLD = 40
	)

	size = SIZE_3
	weight = WEIGHT_5

	value = 250

/obj/item/clothing/head/helmet/security/slavticool
	name = "military helmet"
	icon = 'icons/obj/items/clothing/hats/squad_helmet.dmi'
	desc = "Protecting against the capitalism since 2238."
	desc_extended = "Durable combat helmet made out of complex plastic-based bullet-resistant materials and ceramics. Should save you from a bullet or five."

	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 35,
		BLUNT = 40,
		PIERCE = 65,
		LASER = 40,
		MAGIC = -75,
		HEAT = 40,
		CODL = 40
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 150

/obj/item/clothing/overwear/hardsuit/exosuit
	name = "russian exosuit"
	icon = 'icons/obj/items/clothing/suit/exosuit.dmi'
	desc = "RIP Tachenko."
	desc_extended = "An experimental sample of a military exoskeleton. Was never mass-produced due to extraordinary cost and some design flaws. Despite this, it is in demand due to its ability to take on the weight of all carried equipment, and therefore small batches are made in underground facilities."
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 65,
		BLUNT = 85,
		PIERCE = 100,
		LASER = 65,
		MAGIC = -60,
		HEAT = 85,
		COLD = 85,
		BOMB = 85,
		BIO = 85,
		RAD = 85
	)

	size = SIZE_7
	weight = WEIGHT_7

	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/exosuit)

	slowdown_mul_worn = 1.3 // (Balanced) Design flaws. :P

	value = 500 //Extraordinary cost. :P

/obj/item/clothing/head/helmet/hardsuit/exosuit
	name = "exosuit helmet"
	icon = 'icons/obj/items/clothing/hats/exosuit_helmet.dmi'
	desc = "Duty more like dooty."
	desc_extended = "So, it's an exosuit's helmet. It protects. It is cool, because gas masks are cool."
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 55,
		BLUNT = 75,
		PIERCE = 85,
		LASER = 45,
		MAGIC = -60,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 85,
		RAD = 85
	)

	size = SIZE_4
	weight = WEIGHT_5

	value = 250

/obj/item/clothing/overwear/hardsuit/psz
	name = "\improper PSZ-9d"
	icon = 'icons/obj/items/clothing/suit/psz.dmi'
	desc = "Get out of here, PMC."
	desc_extended = "This late model of the revolutionist bodysuit is the Spetsnaz PSZ-9 body armor modified for the extreme combat situations. The suit is capable of stopping a rifle bullet, however, this level of protection comes at the cost of its weight, bulkiness and virtually non-existent magic protection."
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 75,
		BLUNT = 95,
		PIERCE = 100,
		LASER = 65,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 85,
		RAD = 85
	)

	size = SIZE_7
	weight = WEIGHT_5

	additional_clothing =  list(/obj/item/clothing/head/helmet/hardsuit/psz)

	slowdown_mul_worn = 1.25

	value = 500

/obj/item/clothing/head/helmet/hardsuit/psz
	name = "\improper Sphere M12 helmet"
	icon = 'icons/obj/items/clothing/hats/psz.dmi'
	desc = "I said come in, don't stand there."
	desc_extended = "An aluminum/titanium helmet with a cloth exterior that comes with pockets for additional steel armor pieces and an armor face mask. Sphere M12 is normally used as part of a combination that includes PSZ series Spetsnaz body armor."
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 55,
		BLUNT = 85,
		PIERCE = 100,
		LASER = 45,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 85,
		RAD = 85
	)

	size = SIZE_4
	weight = WEIGHT_3

	value = 250