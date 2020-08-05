/obj/item/clothing/overwear/hardsuit/engineering
	name = "engineering hardsuit"
	desc = "The SM is at 9% health? Eh, it's probably gonna be fine"
	desc_extended = "A hardsuit worn by engineers. Able to withstand incredible heat in order to work with engines."
	icon = 'icons/obj/item/clothing/suit/engineering_rig.dmi'
	rarity = RARITY_UNCOMMON
	value = 200

	defense_rating = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 25,
		LASER = 25,
		ARCANE = -75,
		HEAT = 100,
		COLD = 100,
		BOMB = 25,
		BIO = 50,
		RAD = 75,
		FATIGUE = INFINITY
	)

	size = SIZE_7


	additional_clothing = list(
		/obj/item/clothing/head/helmet/hardsuit/engineering,
		/obj/item/clothing/hands/gloves/engineering,
		/obj/item/clothing/hands/gloves/engineering/left,
		/obj/item/clothing/feet/shoes/engineering,
		/obj/item/clothing/feet/shoes/engineering/left
	)

	slowdown_mul_worn = 1.3