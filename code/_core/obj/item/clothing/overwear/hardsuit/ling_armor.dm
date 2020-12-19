/obj/item/clothing/overwear/hardsuit/ling
	name = "living flesh armor"
	desc = "Holy fuck what is this?"
	desc_extended = "A clusterfuck of metal and flesh fused into living armor. This must make you do some pretty fucking wacky shit."
	icon = 'icons/obj/item/clothing/suit/ling_armor.dmi'
	rarity = RARITY_LEGENDARY
	value = 5000

	defense_rating = list(
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_CLUB,
		ARCANE = -AP_CLUB,
		HEAT = -AP_CLUB,
		COLD = AP_CLUB,
		BIO = AP_CLUB,
		RAD = AP_CLUB
	)

	size = SIZE_7


	additional_clothing = list(
		/obj/item/weapon/melee/sword/armblade
	)