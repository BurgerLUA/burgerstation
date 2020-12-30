/obj/item/clothing/overwear/hardsuit/engineering
	name = "engineering hardsuit"
	desc = "The SM is at 9% health? Eh, it's probably gonna be fine"
	desc_extended = "A hardsuit worn by engineers. Able to withstand incredible heat in order to work with engines."
	icon = 'icons/obj/item/clothing/suit/engineering_rig.dmi'
	rarity = RARITY_UNCOMMON
	value = 200

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = AP_SWORD,
		ARCANE = -AP_CLUB,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		BOMB = AP_SWORD,
		BIO = AP_CLUB,
		RAD = AP_CLUB,
		FATIGUE = AP_SWORD,
		PAIN = AP_SWORD
	)

	size = SIZE_7

	additional_clothing = list(
		/obj/item/clothing/head/helmet/hardsuit/engineering,
		/obj/item/clothing/hands/gloves/engineering,
		/obj/item/clothing/hands/gloves/engineering/left,
		/obj/item/clothing/feet/shoes/engineering,
		/obj/item/clothing/feet/shoes/engineering/left
	)

	loyalty_tag = "NanoTrasen"