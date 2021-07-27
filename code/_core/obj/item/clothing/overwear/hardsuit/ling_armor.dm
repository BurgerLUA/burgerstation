/obj/item/clothing/overwear/hardsuit/ling
	name = "living flesh armor"
	desc = "Holy fuck what is this?"
	desc_extended = "A clusterfuck of metal and flesh fused into living armor. This must make you do some pretty fucking wacky shit."
	icon = 'icons/obj/item/clothing/suit/ling_armor.dmi'
	rarity = RARITY_LEGENDARY
	value = 5000

	defense_rating = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 60,
		LASER = -60,
		ARCANE = -60,
		HEAT = -60,
		COLD = 60,
		BIO = 60,
		RAD = 60
	)

	size = SIZE_7


	additional_clothing = list(
		/obj/item/weapon/melee/sword/armblade,
		/obj/item/weapon/ranged/stamina_use/tentacle
	)
