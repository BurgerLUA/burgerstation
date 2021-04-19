/obj/item/clothing/overwear/hardsuit/medical
	name = "medical voidsuit"
	desc = "Out the fucking way!"
	desc_extended = "A hardsuit worn by medics while retrieving corpses to avoid becoming a corpse themselves."
	icon = 'icons/obj/item/clothing/suit/hardsuit_medical.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 20,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 20,
		ARCANE = -40,
		HEAT = 40,
		COLD = 40,
		BOMB = 20,
		BIO = 120,
		RAD = 60
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/medical)

	value = 1000

	loyalty_tag = "NanoTrasen"