/obj/item/clothing/overwear/hardsuit/ling
	name = "living flesh armor"
	desc = "Holy fuck what is this?"
	desc_extended = "A clusterfuck of metal and flesh fused into living armor. This must make you do some pretty fucking wacky shit."
	icon = 'icons/obj/item/clothing/suit/ling_armor.dmi'
	rarity = RARITY_LEGENDARY
	value = 5000

	defense_rating = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = -25,
		MAGIC = -50,
		HEAT = -50,
		COLD = 100,
		BIO = 100,
		RAD = 100
	)

	size = SIZE_7
	weight = WEIGHT_5

	additional_clothing = list(
		/obj/item/weapon/melee/sword/armblade,
		/obj/item/weapon/melee/sword/armblade
	)

	slowdown_mul_worn = 0.9