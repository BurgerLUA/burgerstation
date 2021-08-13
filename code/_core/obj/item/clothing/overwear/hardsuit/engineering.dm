/obj/item/clothing/overwear/hardsuit/engineering
	name = "engineering hardsuit"
	desc = "The SM is at 9% health? Eh, it's probably gonna be fine"
	desc_extended = "A hardsuit worn by engineers. Able to withstand incredible heat in order to work with engines."
	icon = 'icons/obj/item/clothing/suit/engineering_rig.dmi'
	rarity = RARITY_UNCOMMON
	value = 1500

	defense_rating = list(
		BLADE = 25,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 20,
		ARCANE = -60,
		HEAT = 60,
		COLD = 60,
		BOMB = 20,
		BIO = 60,
		RAD = 60,
		FATIGUE = 20,
		PAIN = 20
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