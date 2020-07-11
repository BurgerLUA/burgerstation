/obj/item/clothing/overwear/hardsuit/medical
	name = "medical voidsuit"
	desc = "Out the fucking way!"
	desc_extended = "A hardsuit worn by medics while retrieving corpses to avoid becoming a corpse themselves."
	icon = 'icons/obj/item/clothing/suit/hardsuit_medical.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		DARK = -25,
		HOLY = 25,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = 100,
		RAD = 100
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/medical)

	slowdown_mul_worn = 1

	value = 80